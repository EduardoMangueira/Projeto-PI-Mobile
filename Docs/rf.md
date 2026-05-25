## Requisitos Funcionais (RF)

### RF01 — Login do Usuário
O sistema deve permitir que o usuário realize login com usuário e senha própria.

### RF02 — Quantidade no Estoque 
O sistema tem que deixar o usuário alterar a quantidade de estoque existente, permitindo adicionar, subtrair ou excluir um item especifico.

### RF03 — Baixa Automática no Estoque
Sistema deve registrar automáticamente quando houver uma venda, diminuindo a quantidade no estoque.

### RF04 — Calculo de Lucro
O sitema deve armazenar a regra de negócio, para colocar no relátório final.

### RF05 — Converter texto(IA) em escrita
O funcionário escreve a venda, e a IA analisa a venda, facilitando a transcrição para o relatório final.

### RF06 — Cadastro de Usuário
O sistema deve permitir que o próprio usuário realize seu cadastro informando e-mail, senha, nome de usuário e telefone.

### RF07 — Gestão das Vendas e Compras
O sistema deve listar as movimentações financeiras (vendas e compras) com item, data e valor, permitindo filtrar por tipo.

### RF08 — Alerta de Estoque Crítico
O sistema deve emitir notificações visuais (na tela de Notificações) quando um produto ou insumo atingir uma quantidade mínima pré-definida pelo usuário.

### RF09 — Cadastro de Insumos e Produtos Finais
O sistema deve permitir o cadastro de insumos (tinta, papel, fitas) e de produtos finais (caneca, camiseta), vinculando os custos de insumos ao preço de custo do produto final para o cálculo automático de margem.

### RF10 — Visualização de Dashboard
O sistema deve exibir um resumo financeiro e operacional na tela inicial, incluindo Lucro Líquido, Receita Total e um gráfico comparativo de Receitas vs Despesas.

### RF11 — Processamento de Linguagem Natural (NLP) para Vendas
O sistema deve ser capaz de interpretar o texto transcrito do áudio (RF05) para identificar automaticamente o produto, a quantidade e o valor, solicitando confirmação do usuário antes de efetivar a baixa no estoque.

### RF12 — Geração de Relatório de Desempenho (Insights de IA)
O sistema deve gerar uma análise preditiva simples no relatório mensal, destacando quais produtos foram mais vendidos e sugerindo ações (ex: "Canecas lideram as vendas, considere ampliar a variedade").

### RF13 — Histórico Detalhado de Movimentações
O sistema deve manter um log (registro) de todas as entradas e saídas manuais ou automáticas, permitindo a auditoria de quem alterou o estoque e quando.

### RF14 — Composição de Custo por Produto (Ficha Técnica)
O sistema deve permitir que o usuário defina quais insumos compõem um produto final (ex: 1 Caneca Branca = 1 unidade de caneca + 5ml de tinta + 1 folha de papel sublimático) para que o abatimento no estoque seja preciso.

### RF15 — Edição de Perfil de Usuário
O sistema deve permitir que o usuário altere seus dados cadastrais (nome, telefone, senha) e faça o upload de uma imagem de perfil ou logo da empresa.

### RF16 — Recuperação de Senha
O sistema deve oferecer uma funcionalidade de "Esqueci minha senha", enviando um código ou link de redefinição para o e-mail cadastrado.

### RF17 — Confirmação de Transcrição da IA
Após a conversão de áudio/texto para comando de venda, o sistema deve exibir um modal ou tela de confirmação com os dados extraídos (Produto, Quantidade, Valor) para que o usuário valide antes de salvar no banco de dados.

### RF18 — Análise de Tendências (IA Preditiva)
O sistema deve analisar o histórico de vendas para prever a falta de estoque futura, emitindo avisos como: "Baseado nas vendas das últimas 2 semanas, seu estoque de Canecas acabará em 3 dias."

### RF19 — Exportação de Relatórios
O sistema deve permitir a exportação dos relatórios mensais e fluxos de caixa em formato PDF ou CSV para fins contábeis externos.

### RF20 — Persistência de Dados (Offline Sync)
O sistema deve permitir a visualização dos dados básicos de estoque mesmo sem conexão com a internet, sincronizando as alterações assim que a conexão for restabelecida.

### RF21 — Validação de Campos Obrigatórios
O sistema deve impedir o cadastro de produtos ou vendas com campos vazios ou valores negativos, exibindo mensagens de erro amigáveis ao usuário.

### RF22 — Log de Atividades (Auditoria)
O sistema deve registrar a data e hora de cada alteração feita no estoque ou exclusão de venda para evitar perdas acidentais de informações.
