// server.js
const fs = require('fs');
const http = require('http');
const express = require('express');
const { Server } = require('socket.io');

const offerMap = {};

const app = express();
const httpsServer = http.createServer(app);

const io = new Server(httpsServer, {
  cors: {
    origin: '*',
  },
});

app.get('/', (req, res) => {
  res.send('WebRTC Signaling Server is running.');
});

httpsServer.listen(4433, () => {
  console.log('HTTPS Signaling Server listening on port 4433');
});

io.on('connection', (socket) => {
  console.log('A client connected:', socket.id);

  socket.on('join-call', (callId) => {
    socket.join(callId);
    console.log(`${socket.id} joined call: ${callId}`);
    console.log('offer Map 1:', offerMap);
    if (offerMap[callId]) {
      socket.emit('offer', {
        sdp: offerMap[callId].sdp,
        type: offerMap[callId].type
      }); 
    }
  });

  socket.on('offer', (payload) => {
    console.log('Got offer from:', socket.id, 'payload:', payload);
    console.log('offer Map 2:', offerMap);
    const { callId, sdp, type } = payload;
    offerMap[callId] = { sdp, type };
    socket.to(callId).emit('offer', { sdp, type });
  });

  socket.on('answer', (payload) => {
    console.log('Got answer from:', socket.id, 'payload:', payload);
    socket.to(payload.callId).emit('answer', {
      sdp: payload.sdp,
      type: payload.type,
    });
  });

  socket.on('candidate', (payload) => {
    console.log('Got candidate from:', socket.id, 'payload:', payload);
    socket.to(payload.callId).emit('candidate', {
      candidate: payload.candidate,
    });
  });

  socket.on('disconnect', () => {
    console.log('Client disconnected:', socket.id);
  });
});