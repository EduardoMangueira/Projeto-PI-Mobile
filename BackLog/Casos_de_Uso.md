# Casos de Uso do Sistema

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
  
<img width="486" height="505" alt="image" src="https://github.com/user-attachments/assets/74bcb814-2be6-466b-b1c4-777ad5b3968c" />

<img width="1005" height="174" alt="image" src="https://github.com/user-attachments/assets/2aaec898-252a-4609-80a3-77fd433ebb45" />


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
 
<img width="552" height="159" alt="image" src="https://github.com/user-attachments/assets/5a43406e-d4c0-4df5-8fcb-5bbc0b7a66b3" />


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

<img width="502" height="270" alt="image" src="https://github.com/user-attachments/assets/a6b8003f-05f7-49e8-8f9d-67642b804350" />

<img width="934" height="240" alt="image" src="https://github.com/user-attachments/assets/74ff562e-94cb-439c-b5a8-5edc42cf9adc" />


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

<img width="464" height="299" alt="image" src="https://github.com/user-attachments/assets/9cf61db8-138f-4ffb-85bc-47f916142690" />

<img width="932" height="193" alt="image" src="https://github.com/user-attachments/assets/330d54ad-8206-4b6f-a5fd-69537348e763" />


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

 <img width="492" height="286" alt="image" src="https://github.com/user-attachments/assets/9a192932-4b57-41a8-9b7e-e8797883c62f" />

 <img width="1045" height="197" alt="image" src="https://github.com/user-attachments/assets/a7c123a3-daa6-4e3f-a65b-bd66e84b975b" />
 

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

<img width="633" height="260" alt="image" src="https://github.com/user-attachments/assets/3076fde4-d46e-46e7-9482-5df78f551bbb" />

<img width="1030" height="196" alt="image" src="https://github.com/user-attachments/assets/a4fefaa2-8c26-4285-ade6-c371d53f9db1" />


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

<img width="609" height="159" alt="image" src="https://github.com/user-attachments/assets/06961bb0-ed37-4339-b6d7-5814ada74865" />


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

<img width="483" height="343" alt="image" src="https://github.com/user-attachments/assets/ff893eb2-00d4-4083-a9f1-87e815b9cf52" />

<img width="731" height="193" alt="image" src="https://github.com/user-attachments/assets/5ce7d4d4-86c8-4537-a29b-b40683bda82b" />


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

<img width="569" height="355" alt="image" src="https://github.com/user-attachments/assets/ae3b4de0-1011-4abf-807f-c9cdbc221142" />

<img width="1088" height="163" alt="image" src="https://github.com/user-attachments/assets/a95e0b71-4dc3-4384-ab94-4c5c7d5c25cf" />


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

<img width="602" height="388" alt="image" src="https://github.com/user-attachments/assets/293a6380-7509-4226-bd12-1fb9c3844c5b" />


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

<img width="578" height="260" alt="image" src="https://github.com/user-attachments/assets/e3024a87-732b-4e96-bed2-9f02e450f881" />

<img width="926" height="217" alt="image" src="https://github.com/user-attachments/assets/e7321bc1-a219-4895-b198-3e4d4a766732" />


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

<img width="737" height="368" alt="image" src="https://github.com/user-attachments/assets/48b94014-4052-4b8a-b5e8-c1f1c337ac82" />


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

<img width="337" height="152" alt="image" src="https://github.com/user-attachments/assets/8b20c2e4-ae6f-4870-995c-38da14319d7c" />

<img width="1085" height="219" alt="image" src="https://github.com/user-attachments/assets/39708ae2-f280-4797-9a2f-2247efd91c04" />


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

<img width="303" height="165" alt="image" src="https://github.com/user-attachments/assets/43f10a9b-8086-4f06-821c-2263e3297adf" />

<img width="1075" height="177" alt="image" src="https://github.com/user-attachments/assets/6e39d8af-ace2-4312-b512-fb11725be2c9" />


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

<img width="565" height="207" alt="image" src="https://github.com/user-attachments/assets/a114989c-a46c-4e6c-9a1a-b8f53d33d694" />

<img width="1089" height="214" alt="image" src="https://github.com/user-attachments/assets/8fa270e9-e62c-40e4-ae93-a2ab415be713" />

