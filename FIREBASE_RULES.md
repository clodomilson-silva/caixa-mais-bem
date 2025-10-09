# 🔥 Configuração das Regras do Firebase Firestore

## ❌ **Problema Atual**

As regras do Firestore estão atualmente configuradas para **bloquear todo acesso**:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;  // ❌ Bloqueia tudo
    }
  }
}
```

## ✅ **Soluções**

### **1. Regras Seguras para Produção (Recomendado)**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Permite acesso apenas aos dados do próprio usuário autenticado
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Permite acesso aos moods apenas do próprio usuário
    match /moods/{moodId} {
      allow read, write: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
    
    // Permite criação de moods apenas para o próprio usuário
    match /moods/{moodId} {
      allow create: if request.auth != null && 
        request.resource.data.userId == request.auth.uid;
    }
  }
}
```

### **2. Regras Abertas para Desenvolvimento (Temporário)**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;  // Permite se estiver autenticado
    }
  }
}
```

### **3. Sistema Mock Automático (Já Implementado)**

O app possui um sistema de fallback automático que detecta erros de permissão e muda automaticamente para o modo Mock local, permitindo desenvolvimento sem depender das regras do Firebase.

## 🛠️ **Como Aplicar as Regras**

1. Acesse o [Console do Firebase](https://console.firebase.google.com/)
2. Selecione seu projeto
3. Vá em **Firestore Database**
4. Clique na aba **Rules**
5. Cole uma das regras acima
6. Clique em **Publish**

## 🔧 **Status Atual do App**

- ✅ **Sistema de fallback implementado**: App funciona mesmo com regras bloqueadas
- ✅ **Logs informativos**: Mostra quando muda para Mock
- ✅ **Desenvolvimento funcionando**: Pode testar toda funcionalidade localmente
- ⚠️ **Dados temporários**: Dados salvos no Mock não persistem entre sessões

## 📱 **Para Produção**

Recomenda-se usar as **regras seguras** que permitem acesso apenas aos dados do próprio usuário autenticado, garantindo privacidade e segurança dos dados.