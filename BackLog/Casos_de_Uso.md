# Casos de Uso do Sistema

## Diagrama de Casos de Uso — Geral

<img width="795" height="1128" alt="Diagrama_Geral_Sistema" src="https://github.com/user-attachments/assets/96e1c0fb-8cdb-4943-9800-ce7662eb1e14" />

## Diagrama de Classes de Domínio

<img width="905" height="1350" alt="Diagrama_Dominio_Sistema" src="https://github.com/user-attachments/assets/adace524-517d-4b93-bf75-a451e9451a60" />

## UC01 — Realizar Login

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário acesse o sistema.

**Pré-condições:**
- Usuário deve possuir cadastro ativo.

**Pós-condições:**
- Sessão iniciada com sucesso.

**Fluxo Principal:**
1. O usuário informa e-mail e senha.
2. O sistema valida as credenciais.
3. O sistema autentica o usuário e redireciona para a tela inicial.

**Fluxos Alternativos:**
- **A1 — Credenciais inválidas:**
  - O sistema exibe mensagem de erro e retorna ao formulário.
- **A2 — Conta bloqueada (inativa há 90 dias):**
  - O sistema marca como inativa e bloqueia o acesso automaticamente.
- **A3 - Esqueceu a senha:**
  - O usuário aciona "Recuperar Senha" e redefine via e-mail.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)
  
<img width="486" height="505" alt="image" src="https://github.com/user-attachments/assets/74bcb814-2be6-466b-b1c4-777ad5b3968c" />

<img width="1005" height="174" alt="image" src="https://github.com/user-attachments/assets/2aaec898-252a-4609-80a3-77fd433ebb45" />

<img width="759" height="546" alt="UC01_Atividade" src="https://github.com/user-attachments/assets/eb6dbf22-e6bc-420c-a72f-7825fe2f81ce" />

<img width="672" height="724" alt="UC01_Sequencia" src="https://github.com/user-attachments/assets/fd4cedda-6615-4e93-96f6-26d6aac10e14" />

## UC02 — Recuperar Senha

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário redefina sua senha em caso de esquecimento.

**Pré-condições:**
- Usuário deve possuir cadastro ativo.

**Pós-condições:**
- Senha redefinida com sucesso e acesso restabelecido.

**Fluxo Principal:**
1. O usuário aciona "Recuperar Senha" na tela de login.
2. O usuário informa o e-mail cadastrado.
3. O sistema envia um link de redefinição para o e-mail.
4. O usuário acessa o link e define uma nova senha.
5. O sistema confirma a alteração e redireciona para o login.

**Fluxos Alternativos:**
- **A1 — E-mail não cadastrado:**
  - O sistema exibe aviso e não envia nenhum e-mail.
- **A2 — Link expirado:**
  - O sistema informa a expiração e o usuário solicita um novo link.
- **A3 — Nova senha igual à anterior:**
  - O sistema rejeita e solicita que o usuário defina uma senha diferente.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)
 
<img width="552" height="159" alt="image" src="https://github.com/user-attachments/assets/5a43406e-d4c0-4df5-8fcb-5bbc0b7a66b3" />

<img width="752" height="659" alt="UC02_Atividade" src="https://github.com/user-attachments/assets/6db38493-695a-44cc-9291-8e88ae518366" />

<img width="839" height="1034" alt="UC02_Sequencia" src="https://github.com/user-attachments/assets/373f4a7c-e135-4ab0-92e8-95b0a548535c" />

## UC03 — Gerenciar Perfil

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário visualize e edite seus dados pessoais e de acesso.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Dados atualizados e salvos com sucesso.

**Fluxo Principal:**
1. O usuário acessa a tela de Perfil.
2. O usuário edita os dados desejados (nome, e-mail, telefone ou senha).
3. O sistema valida as informações.
4. O sistema salva as alterações e exibe confirmação.

**Fluxos Alternativos:**
- **A1 — Senha atual incorreta ao tentar alterar senha:**
  - O sistema rejeita a operação e solicita correção.
- **A2 — Dados inválidos no formulário:**
  - O sistema aponta os campos com erro antes de salvar.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="502" height="270" alt="image" src="https://github.com/user-attachments/assets/a6b8003f-05f7-49e8-8f9d-67642b804350" />

<img width="934" height="240" alt="image" src="https://github.com/user-attachments/assets/74ff562e-94cb-439c-b5a8-5edc42cf9adc" />

<img width="834" height="611" alt="UC03_Atividade" src="https://github.com/user-attachments/assets/ccd7217f-e505-412b-8c09-7966ce63b234" />

<img width="626" height="784" alt="UC03_Sequencia" src="https://github.com/user-attachments/assets/3fcd073f-d198-430f-b965-2fa348d74bb5" />

## UC04 — Visualizar Inventário

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário visualize todos os produtos cadastrados no estoque.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Lista de produtos exibida com foto e quantidade atualizada.

**Fluxo Principal:**
1. O usuário acessa a tela de Inventário.
2. O sistema carrega e exibe os produtos com foto, nome e quantidade.
3. O usuário navega pela lista de produtos.

**Fluxos Alternativos:**
- **A1 — Inventário vazio:**
  - O sistema exibe mensagem "Nenhum produto cadastrado" com atalho para adicionar.
- **A2 — Sem conexão:**
  - O sistema exibe os dados do cache local em modo offline.
- **A3 — Produto com estoque crítico:**
  - O item é destacado visualmente na lista.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="464" height="299" alt="image" src="https://github.com/user-attachments/assets/9cf61db8-138f-4ffb-85bc-47f916142690" />

<img width="932" height="193" alt="image" src="https://github.com/user-attachments/assets/330d54ad-8206-4b6f-a5fd-69537348e763" />

<img width="866" height="591" alt="UC04_Atividade" src="https://github.com/user-attachments/assets/878a1550-7ab3-46fd-817c-a894334c8294" />

<img width="946" height="726" alt="UC04_Sequencia" src="https://github.com/user-attachments/assets/2614efd8-6aff-4609-8c2b-3d45ecf7b45d" />

## UC05 — Adicionar Item ao Estoque

**Ator Principal:** Usuário

**Objetivo:** Permitir o cadastro de novos produtos no inventário.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Novo produto cadastrado e disponível no inventário.

**Fluxo Principal:**
1. O usuário acessa a tela de Adicionar Item.
2. O usuário preenche nome, quantidade, custo por unidade e desconto.
3. O usuário adiciona uma foto ao produto (opcional).
4. O sistema valida os dados e salva o produto.
5. O produto passa a aparecer na lista do inventário.

**Fluxos Alternativos:**
- **A1 — Campos obrigatórios vazios:**
  - O sistema bloqueia o salvamento e aponta os campos pendentes.
- **A2 — Produto com nome já existente:**
  - O sistema alerta duplicidade e pergunta se o usuário deseja continuar.
- **A3 — Foto não selecionada:**
  - O produto é salvo sem foto, exibindo um ícone padrão.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

 <img width="492" height="286" alt="image" src="https://github.com/user-attachments/assets/9a192932-4b57-41a8-9b7e-e8797883c62f" />

 <img width="1045" height="197" alt="image" src="https://github.com/user-attachments/assets/a7c123a3-daa6-4e3f-a65b-bd66e84b975b" />

 <img width="597" height="810" alt="UC05_Atividade" src="https://github.com/user-attachments/assets/4078fb1c-ba81-4f22-9b5b-a9304adb2f7e" />

 <img width="745" height="880" alt="UC05_Sequencia" src="https://github.com/user-attachments/assets/9449017b-3616-4b02-b3bc-0f5e9aaa5f27" />

## UC06 — Alterar Quantidade no Estoque

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário adicione ou subtraia a quantidade de um produto específico.

**Pré-condições:**
- Usuário autenticado no sistema.
- Produto previamente cadastrado no inventário.

**Pós-condições:**
- Quantidade do produto atualizada e registrada no histórico.

**Fluxo Principal:**
1. O usuário seleciona um produto no inventário.
2. O usuário informa a quantidade a adicionar ou subtrair.
3. O sistema atualiza o estoque e registra a alteração no histórico.

**Fluxos Alternativos:**
- **A1 — Subtração maior que o estoque atual:**
  - O sistema exibe alerta "Estoque insuficiente" e bloqueia a operação.
- **A2 — Sem conexão (modo offline):**
  - A alteração é salva localmente e sincronizada ao reconectar.
- **A3 — Estoque atinge nível crítico após alteração:**
  - O sistema dispara uma notificação push automaticamente.
- **A4 — Estoque atinge nível excessivo após alteração:**
  - O sistema dispara uma notificação push automaticamente.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="633" height="260" alt="image" src="https://github.com/user-attachments/assets/3076fde4-d46e-46e7-9482-5df78f551bbb" />

<img width="1030" height="196" alt="image" src="https://github.com/user-attachments/assets/a4fefaa2-8c26-4285-ade6-c371d53f9db1" />

<img width="513" height="831" alt="UC06_Atividade" src="https://github.com/user-attachments/assets/9336a6fe-fcf9-4266-8127-4372bb5e6187" />

<img width="818" height="867" alt="UC06_Sequencia" src="https://github.com/user-attachments/assets/910eda12-fd5d-4a1b-859c-27bb1426b852" />

## UC07 — Filtrar Inventário

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário filtre e ordene os produtos do inventário por critérios específicos.

**Pré-condições:**
- Usuário autenticado no sistema.
- Ao menos um produto cadastrado no inventário.

**Pós-condições:**
- Lista de produtos exibida conforme os filtros aplicados.

**Fluxo Principal:**
1. O usuário acessa o inventário e aciona os filtros disponíveis.
2. O usuário seleciona critérios (data de criação, nível de estoque, ordenação).
3. O sistema atualiza a lista com os resultados correspondentes.

**Fluxos Alternativos:**
- **A1 — Nenhum produto corresponde ao filtro:**
  - O sistema exibe mensagem "Nenhum resultado encontrado".
- **A2 — Múltiplos filtros combinados:**
  - O sistema aplica todos os critérios simultaneamente.
- **A3 — Filtro removido:**
  - O sistema retorna à listagem completa.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="609" height="159" alt="image" src="https://github.com/user-attachments/assets/06961bb0-ed37-4339-b6d7-5814ada74865" />

<img width="358" height="632" alt="UC07_Atividade" src="https://github.com/user-attachments/assets/4e17a2d5-c215-47df-a568-47448f27be24" />

<img width="803" height="786" alt="UC07_Sequencia" src="https://github.com/user-attachments/assets/adb423ea-f441-476b-a0dc-f1eb11950920" />

## UC08 — Receber Notificação de Estoque

**Ator Principal:** Sistema

**Objetivo:** Alertar o usuário automaticamente sobre variações críticas no nível de estoque.

**Pré-condições:**
- Produto com quantidade cadastrada no inventário.

**Pós-condições:**
- Notificação entregue ao usuário dentro ou fora do aplicativo.

**Fluxo Principal:**
1. O sistema detecta que um produto atingiu nível crítico, estável ou excessivo.
2. O sistema gera e envia uma notificação push para o dispositivo do usuário.
3. O usuário recebe o alerta e pode acessar o inventário diretamente.

**Fluxos Alternativos:**
- **A1 — App fechado:**
  - A notificação aparece na barra do Android mesmo fora do aplicativo.
- **A2 — Múltiplos produtos em nível crítico simultaneamente:**
  - O sistema agrupa os alertas em uma única notificação.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="483" height="343" alt="image" src="https://github.com/user-attachments/assets/ff893eb2-00d4-4083-a9f1-87e815b9cf52" />

<img width="731" height="193" alt="image" src="https://github.com/user-attachments/assets/5ce7d4d4-86c8-4537-a29b-b40683bda82b" />

<img width="413" height="658" alt="UC08_Atividade" src="https://github.com/user-attachments/assets/996d7575-a35d-442f-8f84-ab20f2198f8e" />

<img width="753" height="661" alt="UC08_Sequencia" src="https://github.com/user-attachments/assets/cae84802-6009-4620-a895-e9dd32a38101" />

## UC09 — Registrar Venda por Voz/Texto

**Ator Principal:** Usuário

**Atores Secundários:** IA (Assistente), Sistema

**Objetivo:** Registrar uma venda através de comando de voz ou texto, com cálculo automático de insumos e baixa no estoque.

**Pré-condições:**
- Usuário autenticado no sistema.
- Produto envolvido na venda cadastrado no inventário.

**Pós-condições:**
- Venda registrada, insumos descontados do estoque e dashboard atualizada.

**Fluxo Principal:**
1. O usuário acessa a tela de Chat com a IA.
2. O usuário dita ou digita a descrição da venda.
3. A IA transcreve o áudio (se necessário) e interpreta os dados da venda.
4. A IA calcula os insumos consumidos e o lucro gerado.
5. O sistema exibe um resumo para confirmação do usuário.
6. O usuário confirma a operação.
7. O sistema efetua a baixa automática no estoque.
8. O sistema atualiza a dashboard e registra a venda no histórico.

**Fluxos Alternativos:**
- **A1 — Transcrição falha ou ultrapassa 10 segundos:**
  - O sistema exibe erro e oferece a opção de digitação manual.
- **A2 — Item não reconhecido no inventário:**
  - A IA solicita que o usuário especifique ou cadastre o produto.
- **A3 — Estoque insuficiente para a venda:**
  - O sistema alerta e bloqueia o registro até correção.
- **A4 — Usuário cancela após ver o resumo:**
  - A operação é descartada sem nenhuma alteração no estoque.
- **A5 — Sem conexão:**
  - A IA fica indisponível e o sistema orienta o usuário a registrar manualmente.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="569" height="355" alt="image" src="https://github.com/user-attachments/assets/ae3b4de0-1011-4abf-807f-c9cdbc221142" />

<img width="1088" height="163" alt="image" src="https://github.com/user-attachments/assets/a95e0b71-4dc3-4384-ab94-4c5c7d5c25cf" />

<img width="596" height="1351" alt="UC09_Atividade" src="https://github.com/user-attachments/assets/08697b84-8f09-4c2d-9c34-c5cf80525573" />

<img width="995" height="1267" alt="UC09_Sequencia" src="https://github.com/user-attachments/assets/cac1bafe-7a29-42a6-9fa1-1813f7156f7a" />

## UC10 — Transcrever Áudio em Texto (IA)

**Ator Principal:** IA (Assistente)

**Ator Secundário:** Usuário

**Objetivo:** Converter o áudio ditado pelo usuário em texto para análise e registro.

**Pré-condições:**
- Dispositivo com microfone disponível.
- Conexão com internet ativa.

**Pós-condições:**
- Texto transcrito disponível para interpretação pela IA.

**Fluxo Principal:**
1. O usuário inicia uma gravação de áudio na tela de Chat.
2. O sistema envia o áudio para o serviço de transcrição da IA.
3. A IA processa e retorna o texto transcrito em até 10 segundos.
4. O texto fica disponível para análise do UC09 ou UC11.

**Fluxos Alternativos:**
- **A1 — Áudio muito curto ou silencioso:**
  - A IA solicita uma nova gravação.
- **A2 — Transcrição ultrapassa 10 segundos:**
  - O sistema exibe timeout e oferece digitação manual.
- **A3 — Sem conexão:**
  - A funcionalidade fica indisponível e somente a entrada por texto é permitida.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="602" height="388" alt="image" src="https://github.com/user-attachments/assets/293a6380-7509-4226-bd12-1fb9c3844c5b" />

<img width="605" height="666" alt="UC10_Atividade" src="https://github.com/user-attachments/assets/1e49173a-9d81-43d6-a604-1e4d43ccf62d" />

<img width="670" height="795" alt="UC10_Sequencia" src="https://github.com/user-attachments/assets/4823d856-7697-4298-8844-6011f0fb86ea" />

## UC11 — Adicionar Estoque por Voz/Texto

**Ator Principal:** Usuário

**Ator Secundário:** IA (Assistente)

**Objetivo:** Permitir que o usuário adicione quantidade ao estoque através de comando de voz ou texto.

**Pré-condições:**
- Usuário autenticado no sistema.
- Produto previamente cadastrado no inventário.

**Pós-condições:**
- Quantidade adicionada ao produto e registrada no histórico.

**Fluxo Principal:**
1. O usuário acessa a tela de Chat com a IA.
2. O usuário dita ou digita o produto e a quantidade a adicionar.
3. A IA transcreve (se necessário) e identifica o produto no inventário.
4. O sistema exibe um resumo para confirmação do usuário.
5. O usuário confirma e a quantidade é adicionada ao estoque.

**Fluxos Alternativos:**
- **A1 — Produto não encontrado no inventário:**
  - A IA pergunta se o usuário deseja cadastrar um novo item.
- **A2 — Usuário cancela na confirmação:**
  - A operação é descartada sem alterações.
- **A3 — Quantidade não identificada no áudio:**
  - A IA solicita que o usuário informe a quantidade manualmente.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="578" height="260" alt="image" src="https://github.com/user-attachments/assets/e3024a87-732b-4e96-bed2-9f02e450f881" />

<img width="926" height="217" alt="image" src="https://github.com/user-attachments/assets/e7321bc1-a219-4895-b198-3e4d4a766732" />

<img width="608" height="916" alt="UC11_Atividade" src="https://github.com/user-attachments/assets/c8ee963f-fb60-440d-8532-4562ff0e281d" />

<img width="810" height="929" alt="UC11_Sequencia" src="https://github.com/user-attachments/assets/29766558-2378-46f2-9424-695fd1474ac7" />

## UC12 — Baixa Automática no Estoque

**Ator Principal:** Sistema

**Ator Secundário:** IA (Assistente)

**Objetivo:** Descontar automaticamente os insumos do estoque após a confirmação de uma venda.

**Pré-condições:**
- Venda confirmada pelo usuário no UC09.
- Insumos do produto cadastrados no inventário.

**Pós-condições:**
- Estoque atualizado e operação registrada no histórico.

**Fluxo Principal:**
1. O usuário confirma a venda no UC09.
2. O sistema calcula os insumos consumidos (tinta, papel, etc.).
3. O sistema desconta as quantidades do estoque automaticamente.
4. O sistema registra a operação no histórico com data e hora.

**Fluxos Alternativos:**
- **A1 — Estoque insuficiente para os insumos:**
  - O sistema bloqueia a baixa e alerta o usuário.
- **A2 — Falha na comunicação com o banco:**
  - A operação é salva em fila e reprocessada ao restabelecer a conexão.
- **A3 — Estoque atinge nível crítico após a baixa:**
  - O sistema dispara notificação automática para o usuário.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="737" height="368" alt="image" src="https://github.com/user-attachments/assets/48b94014-4052-4b8a-b5e8-c1f1c337ac82" />

<img width="643" height="643" alt="UC12_Atividade" src="https://github.com/user-attachments/assets/8029ea38-c3b2-470b-929b-7c59e55a8131" />

<img width="787" height="756" alt="UC12_Sequencia" src="https://github.com/user-attachments/assets/f39f8268-8eb1-473f-b5d7-7cc9ee805e56" />

## UC13 — Visualizar Dashboard

**Ator Principal:** Usuário

**Objetivo:** Exibir os dados financeiros relevantes da semana, incluindo lucro, vendas e produtos em destaque.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Dashboard exibida com dados atualizados.

**Fluxo Principal:**
1. O usuário acessa a tela de Dashboard.
2. O sistema carrega e exibe lucro da semana, produtos mais vendidos e resumo financeiro.
3. A dashboard é atualizada automaticamente a cada nova venda registrada.

**Fluxos Alternativos:**
- **A1 — Nenhuma venda registrada no período:**
  - A dashboard exibe estado vazio com orientação ao usuário.
- **A2 — Sem conexão:**
  - A dashboard exibe os últimos dados sincronizados com aviso de desatualização.
- **A3 — Nova venda registrada enquanto o usuário está na tela:**
  - A dashboard atualiza automaticamente em tempo real.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="337" height="152" alt="image" src="https://github.com/user-attachments/assets/8b20c2e4-ae6f-4870-995c-38da14319d7c" />

<img width="1085" height="219" alt="image" src="https://github.com/user-attachments/assets/39708ae2-f280-4797-9a2f-2247efd91c04" />

<img width="617" height="610" alt="UC13_Atividade" src="https://github.com/user-attachments/assets/879c9498-6220-457f-a1bc-1628f526d16b" />

<img width="916" height="775" alt="UC13_Sequencia" src="https://github.com/user-attachments/assets/51324563-c607-49c9-b843-491fbcd3f3a1" />

## UC14 — Consultar Relatório Mensal

**Ator Principal:** Usuário

**Objetivo:** Disponibilizar análise completa do mês com gráficos e resumo textual gerado pela IA.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Relatório exibido com análise gráfica e resumo textual do mês.

**Fluxo Principal:**
1. O usuário acessa a tela de Relatório Mensal.
2. O sistema verifica se o relatório do mês já foi gerado.
3. A IA exibe análise gráfica com lucro, produtos em alta e em baixa.
4. O sistema exibe o resumo textual gerado pela IA sobre o desempenho do mês.

**Fluxos Alternativos:**
- **A1 — Relatório ainda não gerado:**
  - O sistema exibe aviso "Em processamento" e disponibiliza assim que concluído.
- **A2 — Nenhuma venda no mês:**
  - O relatório é gerado com estado vazio e orientação para o próximo mês.
- **A3 — Sem conexão:**
  - O sistema exibe o relatório do mês anterior com aviso de indisponibilidade do atual.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="303" height="165" alt="image" src="https://github.com/user-attachments/assets/43f10a9b-8086-4f06-821c-2263e3297adf" />

<img width="1075" height="177" alt="image" src="https://github.com/user-attachments/assets/6e39d8af-ace2-4312-b512-fb11725be2c9" />

<img width="889" height="552" alt="UC14_Atividade" src="https://github.com/user-attachments/assets/d1d5c3bb-7875-470e-bae3-d7f2b66c10ed" />

<img width="986" height="911" alt="UC14_Sequencia" src="https://github.com/user-attachments/assets/1792441b-9a1a-4b38-a0db-d700e0e11a7d" />

## UC15 — Consultar Histórico de Alterações

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário consulte as últimas alterações e vendas registradas no sistema.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Histórico exibido com registros de alterações e vendas.

**Fluxo Principal:**
1. O usuário acessa a tela de Histórico.
2. O sistema exibe os registros das alterações e vendas dos últimos 7 dias.
3. O usuário navega pelos registros, visualizando produto, data e origem (usuário ou IA).

**Fluxos Alternativos:**
- **A1 — Nenhum registro no período:**
  - O sistema exibe mensagem "Nenhuma alteração encontrada".
- **A2 — Registro feito pela IA:**
  - O histórico identifica a origem como "IA" em vez de "Usuário".
- **A3 — Sem conexão:**
  - O sistema exibe registros salvos localmente até a última sincronização.

## UC16 — Filtrar Histórico por Data

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário filtre os registros do histórico por um intervalo de datas específico.

**Pré-condições:**
- Usuário autenticado no sistema.
- Ao menos um registro disponível no histórico.

**Pós-condições:**
- Histórico exibido conforme o intervalo de datas selecionado.

**Fluxo Principal:**
1. O usuário acessa a tela de Histórico.
2. O usuário aciona o filtro e informa a data inicial e a data final.
3. O sistema retorna os registros dentro do intervalo informado.

**Fluxos Alternativos:**
- **A1 — Data final anterior à data inicial:**
  - O sistema rejeita o intervalo e solicita correção.
- **A2 — Nenhum registro no intervalo selecionado:**
  - O sistema exibe mensagem "Nenhum resultado encontrado".
- **A3 — Intervalo superior a 3 meses:**
  - O sistema limita a consulta ao máximo de 3 meses e informa o usuário.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="565" height="207" alt="image" src="https://github.com/user-attachments/assets/a114989c-a46c-4e6c-9a1a-b8f53d33d694" />

<img width="1089" height="214" alt="image" src="https://github.com/user-attachments/assets/8fa270e9-e62c-40e4-ae93-a2ab415be713" />

<img width="629" height="487" alt="UC15_Atividade" src="https://github.com/user-attachments/assets/7bd07a63-6fd5-464c-a75b-d9cde5ee600f" />

<img width="535" height="717" alt="UC16_Atividade" src="https://github.com/user-attachments/assets/d1c4d7aa-3550-47d3-83b1-286f6f4ce278" />

<img width="954" height="699" alt="UC15_Sequencia" src="https://github.com/user-attachments/assets/f178389d-275f-4703-8c57-c16082bcbb4f" />

<img width="752" height="997" alt="UC16_Sequencia" src="https://github.com/user-attachments/assets/fdbfaa1b-f164-4bea-8c3f-3c21f3e57420" />

## UC17 — Realizar Cadastro

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário crie sua conta no sistema.

**Pré-condições:**
- Usuário não possui cadastro ativo.

**Pós-condições:**
- Conta criada e usuário redirecionado para a tela de login.

**Fluxo Principal:**
1. O usuário acessa a tela de cadastro pelo hiperlink na tela de login.
2. O usuário preenche e-mail, senha, nome de usuário e telefone.
3. O sistema valida os dados informados.
4. O sistema cria a conta e redireciona para a tela de login.

**Fluxos Alternativos:**
- **A1 — E-mail já cadastrado:**
  - O sistema exibe aviso e solicita outro e-mail.
- **A2 — Campos obrigatórios vazios:**
  - O sistema bloqueia o envio e aponta os campos pendentes.
- **A3 — Senha fraca:**
  - O sistema exibe aviso com os requisitos mínimos de senha.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="581" height="245" alt="DUC17_RealizarCadastro" src="https://github.com/user-attachments/assets/df1a5a75-b0e8-4ba2-b263-88344fcba2d5" />

<img width="1071" height="192" alt="UC17_MVP" src="https://github.com/user-attachments/assets/8e050985-753f-4243-b121-63ea48e254d6" />

<img width="1025" height="462" alt="UC17_Atividade" src="https://github.com/user-attachments/assets/e8b6dd04-2ca4-4660-8366-eef5fb74a566" />

<img width="867" height="703" alt="UC17_Sequencia" src="https://github.com/user-attachments/assets/0d0fe236-c300-4439-8f56-1b23290da098" />

## UC18 — Consultar Movimentações

**Ator Principal:** Usuário

**Objetivo:** Permitir que o usuário visualize e filtre o histórico de vendas e compras.

**Pré-condições:**
- Usuário autenticado no sistema.

**Pós-condições:**
- Lista de movimentações exibida conforme o filtro selecionado.

**Fluxo Principal:**
1. O usuário acessa a tela de Movimentações.
2. O sistema exibe todas as movimentações com item, data e valor.
3. O usuário aplica o filtro desejado (Todos, Vendas ou Compras).
4. O sistema atualiza a lista conforme o filtro selecionado.

**Fluxos Alternativos:**
- **A1 — Nenhuma movimentação registrada:**
  - O sistema exibe mensagem "Nenhuma movimentação encontrada".
- **A2 — Nenhum resultado para o filtro aplicado:**
  - O sistema exibe mensagem "Nenhum resultado encontrado" e mantém o filtro ativo.

### Diagramas (Caso de Uso, MVP, Atividade e Sequência)

<img width="676" height="160" alt="DUC18_ConsultarMovimentacoes" src="https://github.com/user-attachments/assets/b1167560-386a-4e50-abe1-873203666921" />

<img width="1069" height="185" alt="UC18_MVP" src="https://github.com/user-attachments/assets/1b5db180-a3d5-4378-a34d-b6643a032f04" />

<img width="833" height="525" alt="UC18_Atividade" src="https://github.com/user-attachments/assets/f9e15272-9dfd-421e-9428-4c6b9e5f4488" />

<img width="943" height="661" alt="UC18_Sequencia" src="https://github.com/user-attachments/assets/9863583c-8e66-4706-9c0c-6c83e89b2e16" />
