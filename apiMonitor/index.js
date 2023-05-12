const express = require('express');
const app = express()

app.use(express.json())

let arrayMonitor = [
    {
        "id": "1",
        "nome": "Bruno Borges de Oliveira",
        "avatar": "./assets/Bruno_Borges_Oliveira_avatar.png",
        "email": "cc22123@g.unicamp.br"
    },
    {
        "id": "2",
        "nome": "Miguel Lopes Braido",
        "avatar": "./assets/Miguel_Lopes_Braido_avatar.png",
        "email": "cc22327@g.unicamp.br"
    },
    {
        "id": "3",
        "nome": "Bruno Silva Concli",
        "avatar": "./assets/Bruno_Silva_Concli_avatar.png",
        "email": "cc22303@g.unicamp.br"
    },
    {
        "id": "4",
        "nome": "Isabela Thais Santos Bergamo",
        "avatar": "./assets/Isabela_Thais_Santos_Bergamo_avatar.png",
        "email": "cc20676@g.unicamp.br"
    },
    {
        "id": "5",
        "nome": "João Pedro F. Barbosa",
        "avatar": "./assets/Joao_Pedro_Barbosa_avatar.png",
        "email": "cc21687@g.unicamp.br"
    },
];

let horarios_monitor = [
    {
        "nome": "Bruno Borges de Oliveira",
        "segunda": {
            "manha": { "comeco": "10:45", "local": "Claudio", "termino": "11:30" },
            "tarde": { "comeco": "13:30", "local": "Multidisciplinar", "termino": "18:15" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "terca": {
            "manha": { "comeco": "08:15", "local": "Claudio", "termino": "10:45" },
            "tarde": { "comeco": "13:30", "local": "Claudio", "termino": "15:00" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "quarta": {
            "manha": { "comeco": "10:45", "local": "Claudio", "termino": "11:30" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "quinta": {
            "manha": { "comeco": "10:00", "local": "Claudio", "termino": "12:15" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "sexta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "sabado": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        }
    },
    {
        "nome": "Miguel Lopes Braido",
        "segunda": {
            "manha": { "comeco": "07:30", "local": "Claudio", "termino": "12:15" },
            "tarde": { "comeco": "13:30", "local": "Claudio", "termino": "14:15" },
            "noite": { "comeco": "18:15", "local": "Claudio", "termino": "19:00" }
        },
        "terca": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "13:30", "local": "Claudio", "termino": "14:15" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "quarta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "13:30", "local": "Claudio", "termino": "14:15" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "quinta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "13:30", "local": "Claudio", "termino": "14:15" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "sexta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "16:00", "local": "Multidisciplinar", "termino": "18:15" },
            "noite": { "comeco": "18:15", "local": "Claudio", "termino": "19:00" }
        },
        "sabado": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        }
    },
    {
        "nome": "Bruno Silva Concli",
        "segunda": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "16:00", "local": "Multi", "termino": "19:00" },
            "noite": { "comeco": "18:15", "local": "Claudio", "termino": "19:45" }
        },
        "terca": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "14:15", "local": "Claudio", "termino": "15:00" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "quarta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "16:45", "local": "Claudio", "termino": "18:15" },
            "noite": { "comeco": "18:15", "local": "", "termino": "19:00" }
        },
        "quinta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "15:00", "local": "Claudio", "termino": "18:15" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "sexta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "18:15", "local": "Claudio", "termino": "19:00" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        },
        "sabado": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        }
    },
    {
        "nome": "Isabela Thais Santos Bergamo",
        "segunda": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "17:30", "local": "Multi", "termino": "19:00" },
            "noite": { "comeco": "20:30", "local": "Lapa", "termino": "21:15" }
        },
        "terca": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "17:30", "local": "Claudio", "termino": "19:00" },
            "noite": { "comeco": "19:00", "local": "Lapa", "termino": "23:00" }
        },
        "quarta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "17:30", "local": "Claudio", "termino": "19:00" },
            "noite": { "comeco": "19:00", "local": "Lapa", "termino": "23:00" }
        },
        "quinta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "17:30", "local": "Claudio", "termino": "19:00" },
            "noite": { "comeco": "19:00", "local": "Lapa", "termino": "23:00" }
        },
        "sexta": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "17:30", "local": "Claudio", "termino": "19:00" },
            "noite": { "comeco": "19:00", "local": "Lapa", "termino": "23:00" }
        },
        "sabado": {
            "manha": { "comeco": "", "local": "", "termino": "" },
            "tarde": { "comeco": "", "local": "", "termino": "" },
            "noite": { "comeco": "", "local": "", "termino": "" }
        }
    }
]

app.get('/api/monitor/get', function (req, res) {
    setTimeout(function () {
      res.header('Access-Control-Allow-Origin', '*').send(200, arrayMonitor);
    }, 3000);
  });
  
  app.get('/api/monitor/getNome/:nome', (req, res) => {
    const nome = req.params.nome;
    const item = arrayMonitor.find(item => item.nome == nome);
    return res.json(item);
  });
  
  app.post('/api/monitor/post', (req, res) => {
    const id = req.body.id;
    const nome = req.body.nome;
    const avatar = req.body.avatar;
    const email = req.body.email;
    return res.json({ id, nome, avatar, email });
  });
  
  app.put('/api/monitor/put/:id', (req, res) => {
    const id = req.params.id;
    const item = arrayMonitor.find(item => item.id == id);
    item.nome = req.body.nome;
    item.avatar = req.body.avatar;
    item.email = req.body.email;
    return res.json(item);
  });
  
  app.get('/api/monitor/delete/:id', (req, res) => {
    const id = req.params.id;
    const item = arrayMonitor.find(item => item.id == id);
    return res.json(item);
  });
  
  // Método para obter os horários de um monitor específico
  // Exemplo: http://localhost:3000/api/monitor/horarios/Bruno%20Borges%20de%20Oliveira
  app.get('/api/monitor/horarios/:nome', (req, res) => {
    const nome = req.params.nome;
    const horarios = horarios_monitor.find(item => item.nome === nome);
    return res.json(horarios);
  });
  
  app.listen(3000);
  console.log('A API está no ar');