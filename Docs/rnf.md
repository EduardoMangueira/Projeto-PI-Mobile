## Requisitos Não Funcionais (RNF)

### RNF01 — Horário do Relátorio
O relátório final, deve ser disponibilizado para o dono, até 12h de uma Segunda-feira.

### RNF02 — Transcrição
A IA deve analisar a venda em até 10 segundos.

### RNF03 — Atualização da Dashboard
A Dashboard, deve ser atualizada a cada venda, ou de 2 em 2 horas(Estamos em dúvida).

### RNF04 — Segurança do Banco
O banco de dados deve haver um Backup automático, para não perder os dados financeiros e de estoque.

### RNF 05 — Modo Offline
O controle de estoque deve funcionar, mesmo sem internet, mesmo que a IA não consiga computar a venda.

### RNF 06 — Alerta de Estoque Mínimo
O sistema deve alertar o usuário quando um produto atingir ou ficar abaixo do estoque mínimo cadastrado.

### RNF07 — Tempo de Resposta da Interface
O sistema deve reagir aos comandos do usuário (troca de telas, clique em botões) em no máximo 2 segundos, garantindo uma navegação fluida.

### RNF08 — Disponibilidade (Uptime)
O sistema deve estar disponível para uso em 99% do tempo, garantindo que o proprietário consiga registrar vendas em qualquer horário comercial.

### RNF09 — Escalabilidade do Banco de Dados
O banco de dados deve ser capaz de suportar o armazenamento de até 10.000 registros de vendas sem perda de performance na geração de relatórios.

### RNF10 — Criptografia de Dados Sensíveis
As senhas dos usuários devem ser armazenadas no banco de dados utilizando algoritmos de hash/criptografia, impedindo que sejam lidas mesmo em caso de vazamento de dados.

RNF11 — Autenticação de Sessão
O sistema deve manter o usuário logado com segurança, mas exigir nova autenticação caso o app fique inativo ou seja reinstalado, protegendo os dados financeiros.

### RNF12 — Responsividade e Adaptabilidade
A interface do aplicativo deve ser adaptável a diferentes tamanhos de tela e resoluções de smartphones (Android e iOS), sem quebrar o layout das Dashboards.

### RNF13 — Facilidade de Aprendizado (Usabilidade)
Um usuário novo deve ser capaz de realizar uma venda ou consultar o estoque em menos de 3 minutos de interação, sem necessidade de ler um manual técnico.

### RNF14 — Precisão da Transcrição
A integração com a API de IA deve garantir uma taxa de assertividade na conversão de áudio para texto de, no mínimo, 85% em ambientes com ruído moderado (comum em oficinas de sublimação).
