# 🧘‍♀️ Caixa Mais Bem

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.9.2-blue.svg" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-3.9.2-blue.svg" alt="Dart Version">
  <img src="https://img.shields.io/badge/Firebase-Latest-orange.svg" alt="Firebase">
  <img src="https://img.shields.io/badge/Platform-Web%20%7C%20iOS%20%7C%20Android-green.svg" alt="Platform">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</div>

<div align="center">
  <h3>🌟 Aplicativo de Bem-Estar para Operadores de Caixa 🌟</h3>
  <p><em>Promovendo saúde física e mental no ambiente de trabalho</em></p>
</div>

---

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Contribuindo](#-contribuindo)
- [Licença](#-licença)
- [Contato](#-contato)

---

## 🎯 Sobre o Projeto

O **Caixa Mais Bem** é um aplicativo mobile desenvolvido especificamente para promover o bem-estar físico e mental de operadores de caixa. Reconhecendo os desafios únicos enfrentados por esses profissionais - como longas horas em pé, estresse relacionado ao atendimento ao cliente e demandas repetitivas - este app oferece ferramentas práticas e cientificamente embasadas para melhorar a qualidade de vida no trabalho.

### 🎯 Objetivos

- **Reduzir o estresse** ocupacional através de técnicas de respiração e relaxamento
- **Promover atividade física** com exercícios adequados para o ambiente de trabalho
- **Monitorar o bem-estar emocional** através de um diário digital personalizado
- **Facilitar pausas regulares** com sistema de alertas inteligentes
- **Educar sobre saúde ocupacional** com conteúdo especializado

---

## ✨ Funcionalidades

### 🏠 **Dashboard Principal**
- Interface intuitiva com acesso rápido a todas as funcionalidades
- Resumo diário do bem-estar do usuário
- Estatísticas personalizadas de progresso

### 🏃‍♂️ **Módulo de Exercícios Físicos**
- **9 categorias de exercícios** específicos para operadores de caixa:
  - Alongamento de pescoço e ombros
  - Exercícios para as mãos e punhos
  - Fortalecimento das pernas
  - Relaxamento das costas
  - Exercícios de postura
  - Ativação da circulação
  - Exercícios oculares
  - Respiração energizante
  - Relaxamento geral
- Links para recursos externos de atividade física
- Instruções detalhadas com tempo estimado

### 🧘 **Módulo Respiração e Relaxamento**
- **9 técnicas guiadas** com animações visuais:
  - Respiração 4-7-8
  - Respiração em caixa
  - Respiração profunda
  - Respiração alternada
  - Respiração energizante
  - Respiração para ansiedade
  - Respiração para foco
  - Respiração para relaxamento
  - Respiração mindfulness
- Cronômetro integrado para cada sessão
- Progresso salvo automaticamente

### 📝 **Diário Emocional Avançado**
- **Registro rápido ou detalhado** do humor
- **14 categorias de emoções** específicas para o contexto de trabalho
- **11 tipos de gatilhos** relacionados ao ambiente de caixa
- **Contexto de trabalho**: turno, volume de clientes, situações específicas
- **Analytics completo**: padrões semanais, emoções mais frequentes
- **Sistema de insights** com sugestões personalizadas
- **Contador de streak** para motivar registros diários
- **Armazenamento local** para máxima privacidade

### ⏰ **Sistema de Alertas de Pausa** *(Em desenvolvimento)*
- Notificações locais programáveis
- Lembretes inteligentes baseados no turno de trabalho
- Sugestões de atividades para as pausas

### 📚 **Conteúdo Educativo** *(Em desenvolvimento)*
- Artigos sobre ergonomia
- Dicas de saúde mental
- Guias de autocuidado
- Recursos sobre direitos trabalhistas relacionados à saúde

---

## 🛠 Tecnologias Utilizadas

### **Frontend**
- **Flutter 3.9.2** - Framework multiplataforma
- **Dart 3.9.2** - Linguagem de programação
- **Material Design 3** - Design system

### **Backend & Serviços**
- **Firebase Core 4.1.0** - Plataforma de desenvolvimento
- **Firebase Auth 6.0.2** - Autenticação de usuários
- **Cloud Firestore 6.0.1** - Banco de dados NoSQL
- **Firebase Storage 13.0.1** - Armazenamento de arquivos

### **Funcionalidades Específicas**
- **SharedPreferences 2.2.2** - Armazenamento local para dados do diário
- **URL Launcher 6.2.4** - Abertura de links externos
- **FL Chart 0.65.0** - Gráficos e visualizações de dados
- **Device Preview** - Teste em múltiplos dispositivos

### **Arquitetura**
- **Repository Pattern** - Separação de responsabilidades
- **Provider/State Management** - Gerenciamento de estado
- **Clean Architecture** - Organização em camadas

---

## 📋 Pré-requisitos

Antes de executar este projeto, certifique-se de ter as seguintes ferramentas instaladas:

- **Flutter SDK** 3.9.2 ou superior
- **Dart SDK** 3.9.2 ou superior
- **Android Studio** ou **VS Code** com extensões do Flutter
- **Git** para controle de versão
- **Conta Firebase** para configuração dos serviços

### **Para desenvolvimento:**
```bash
flutter doctor -v
```
Certifique-se de que todos os itens estejam configurados corretamente.

---

## 🚀 Instalação

### 1. **Clone o repositório**
```bash
git clone git@github.com:clodomilson-silva/caixa-mais-bem.git
cd caixa-mais-bem
```

### 2. **Instale as dependências**
```bash
flutter pub get
```

### 3. **Configure o Firebase**
- Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
- Ative Authentication, Firestore e Storage
- Baixe o arquivo de configuração:
  - `google-services.json` para Android (em `android/app/`)
  - `GoogleService-Info.plist` para iOS (em `ios/Runner/`)

### 4. **Execute o aplicativo**

**Para Web:**
```bash
flutter run -d chrome
```

**Para Android:**
```bash
flutter run -d android
```

**Para iOS:**
```bash
flutter run -d ios
```

---

## 📱 Como Usar

### **Primeiro Acesso**
1. **Cadastre-se** ou faça **login** com sua conta
2. Complete seu **perfil** com informações básicas
3. Explore o **tour inicial** das funcionalidades

### **Uso Diário Recomendado**
1. **Manhã**: Registre seu humor inicial no diário emocional
2. **Durante o trabalho**: Use exercícios rápidos durante as pausas
3. **Momentos de estresse**: Pratique técnicas de respiração
4. **Final do dia**: Faça uma reflexão no diário emocional

### **Funcionalidades Principais**
- **Dashboard**: Visualize seu progresso e estatísticas
- **Exercícios**: Escolha uma categoria e siga as instruções
- **Respiração**: Selecione uma técnica e siga a animação guiada
- **Diário**: Registre rapidamente ou faça um registro detalhado
- **Histórico**: Analise padrões e insights do seu bem-estar

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
├── src/
│   ├── app.dart                       # Configuração principal do app
│   ├── core/                          # Configurações e constantes globais
│   ├── models/                        # Modelos de dados
│   │   ├── mood_entry.dart           # Modelo do diário emocional
│   │   └── user_model.dart           # Modelo do usuário
│   ├── services/                      # Serviços e repositórios
│   │   ├── auth_service.dart         # Serviço de autenticação
│   │   ├── mood_repository.dart      # Repositório do diário emocional
│   │   └── firebase_service.dart     # Serviços Firebase
│   ├── ui/                           # Interface do usuário
│   │   ├── screens/                  # Telas da aplicação
│   │   │   ├── auth/                 # Telas de autenticação
│   │   │   ├── dashboard/            # Dashboard principal
│   │   │   ├── exercises/            # Módulo de exercícios
│   │   │   ├── breathing/            # Módulo de respiração
│   │   │   ├── diary/                # Diário emocional
│   │   │   ├── alerts/               # Sistema de alertas
│   │   │   └── education/            # Conteúdo educativo
│   │   └── widgets/                  # Componentes reutilizáveis
│   └── utils/                        # Utilitários e helpers
```

---

## 🤝 Contribuindo

Contribuições são sempre bem-vindas! Este projeto visa melhorar a qualidade de vida dos operadores de caixa, e sua ajuda é fundamental.

### **Como Contribuir**

1. **Fork** o projeto
2. Crie uma **branch** para sua feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. **Push** para a branch (`git push origin feature/AmazingFeature`)
5. Abra um **Pull Request**

### **Diretrizes**
- Mantenha o código limpo e bem documentado
- Siga as convenções de nomenclatura do Dart/Flutter
- Adicione testes para novas funcionalidades
- Atualize a documentação quando necessário

### **Tipos de Contribuição**
- 🐛 **Bug fixes**
- ✨ **Novas funcionalidades**
- 📝 **Documentação**
- 🎨 **Melhorias de UI/UX**
- 🧪 **Testes**
- 🌐 **Traduções**

---

## 📊 Roadmap

### **Versão 1.1** *(Próxima release)*
- [ ] Sistema completo de alertas de pausa
- [ ] Módulo de conteúdo educativo
- [ ] Modo offline completo
- [ ] Tema escuro

### **Versão 1.2** *(Futuro)*
- [ ] Integração com wearables
- [ ] Relatórios detalhados para gestores
- [ ] Gamificação e sistema de recompensas
- [ ] Chat de suporte psicológico

### **Versão 2.0** *(Visão de longo prazo)*
- [ ] IA para sugestões personalizadas
- [ ] Integração com sistemas de RH
- [ ] Análise preditiva de bem-estar
- [ ] Comunidade de usuários

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

```
MIT License

Copyright (c) 2025 Clodomilson Silva

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 👨‍💻 Contato

**Clodomilson Silva**
- GitHub: [@clodomilson-silva](https://github.com/clodomilson-silva)
- Email: [seu-email@exemplo.com](mailto:seu-email@exemplo.com)
- LinkedIn: [linkedin.com/in/clodomilson-silva](https://linkedin.com/in/clodomilson-silva)

**Link do Projeto**: [https://github.com/clodomilson-silva/caixa-mais-bem](https://github.com/clodomilson-silva/caixa-mais-bem)

---

## 🙏 Agradecimentos

- Comunidade Flutter pelo excelente framework
- Firebase pela infraestrutura robusta
- Operadores de caixa que inspiraram este projeto
- Profissionais de saúde ocupacional que forneceram insights valiosos

---

<div align="center">
  <strong>🌟 Se este projeto ajudou você, considere dar uma estrela! ⭐</strong>
  
  <br><br>
  
  <em>Desenvolvido com ❤️ pensando no bem-estar dos trabalhadores brasileiros</em>
</div>
