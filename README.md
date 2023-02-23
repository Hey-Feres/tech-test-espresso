# Espresso Tech Test

## Sumário
1. Production
2. O que foi feito?
3. O que não foi feito?
4. Sobre Algumas Decisões
5. Sobre a Utilização

#

### Testes

```bash
rspec
```

#

### Production

Para testar em produção deve ser usado o email `walter@espressoapp.com.br` para cadastro. O disparo de emails é feito usando o sandbox do Mailgun, que exige a adição de Destinatários Autorizados para testes, e foi autorizado apenas o email acima.

[Acessar Production Demo](https://salty-basin-86770.herokuapp.com)

### Execução Local

```bash
bundle
rails db:create db:migrate
gem install mailcatcher
mailcatcher --foreground
```

Obs: O mailcatcher deve 

#

### O que foi feito?

Devido ao prazo de execução do teste e bugs durante o desenvolvimento, o teste não pode ser completo com todos os requisitos. Abaixo a lista do que foi desenvolvido.

- Cadastro de Usuários
- Login de Usuários
- Recuperação de Senha Perdida
	- Envio de email com link com token para alterar senha
	- Tela de Alteração da Senha
- Alteração de Senha e Email de Usuários Logados
- Bloqueio de Acesso Após 5 Tentativas de Login Fracassadas
	- Envio de Email com link com token para desbloquear conta
- Reenvio de de Email com link com token para desbloquear conta
- Cadastro de Dispositivo para Autenticação de Multiplos Fatores
- Remoção de Dispositivo para Autenticação de Multiplos Fatores
- Solicitação de Código de Autenticação de Multiplos Fatores Após Login

#

### O que não foi feito?

- Implementação do Rubocop
	- Motivo: Deixei por último e não me restou muito tempo para refatorar o código visando satisfazer as demandas do linter.
- Integração de Captcha
	- Motivo: Por algum motivo que não pude descobrir, o captcha sempre se comportava como "Inválido". O código no entanto está presente em:
		- `config/initializers/recaptcha.rb`
		- `app/views/devise/shared/_recaptcha.html.erb`
		- `app/controllers/devise/registrations_controller.rb` [Linha 4 e Linhas 153..164]
		- `app/controllers/devise/sessions_controller.rb` [Linha 4 e Linhas 63..72]


#

### Sobre Algumas Decisões

Foi utilizada a biblioteca [Shards](https://designrevision.com/demo/shards/) para desenvolvimento da UI. A decisão foi baseada na simplicidade de instação, setup e utilização, além de possuir componentes visuais bem minimalistas e elegantes.

Toda a UI está em inglês pois considero uma abordagem mais apropriada o uso do inglês como base e a integração do `I18N` para internacionalização da aplicação. Infelizmente não tive tempo de implementar o `I18N`.

#

### Sobre a Utilização

A senha aceita utilizada para testes durante o desenvolvimento foi `Aa@123456789012`, no entanto qualquer senha contendo os critérios solicitados funcionará normalmente.
