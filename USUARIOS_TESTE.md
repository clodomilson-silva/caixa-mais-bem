# 👥 Usuários de Teste - Caixa Mais Bem

## 🔐 Sistema de Autenticação

O aplicativo agora possui autenticação real implementada com Firebase Auth. Apenas usuários cadastrados podem fazer login.

## 📱 Usuários de Teste Disponíveis

Para testar o aplicativo, você pode usar os seguintes usuários pré-cadastrados:

### 👨‍💼 Usuário Administrador
- **Email:** `admin@caixamaisbem.com`
- **Senha:** `admin123`
- **Perfil:** Administrador do sistema

### 🧪 Usuário de Teste
- **Email:** `test@caixamaisbem.com`
- **Senha:** `test123`
- **Perfil:** Usuário para testes gerais

### 👤 Usuário Padrão
- **Email:** `user@caixamaisbem.com`
- **Senha:** `user123`
- **Perfil:** Usuário comum

### 🎯 Usuário Demo
- **Email:** `demo@caixamaisbem.com`
- **Senha:** `demo123`
- **Perfil:** Demonstração

## 🚨 Importante

- ✅ **Login funciona apenas com credenciais válidas**
- ❌ **Qualquer outro email/senha será rejeitado**
- 🔄 **É possível criar novos usuários através da tela de cadastro**
- 🛡️ **Removidas todas as opções de bypass de autenticação**

## 🔧 Funcionamento Técnico

- Se o Firebase estiver configurado: usa autenticação real
- Se o Firebase não estiver disponível: usa sistema mock com os usuários acima
- Em ambos os casos, apenas credenciais válidas são aceitas

## 🆕 Cadastro de Novos Usuários

Na tela de registro, é possível criar novos usuários que serão:
- Salvos no Firebase Auth (se disponível)
- Adicionados ao banco de dados de usuários
- Capazes de fazer login imediatamente

## ⚠️ Mensagens de Erro

O sistema agora exibe mensagens específicas para:
- Usuário não encontrado
- Senha incorreta
- Email inválido
- Credenciais inválidas
- Outros erros de autenticação