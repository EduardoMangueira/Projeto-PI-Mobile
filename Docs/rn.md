## Regras de Negócio (RN)

### RN01 — Maioridade
Para criar uma conta, o usuário deve ter mais de 18 anos.

### RN02 — Bloqueio por Inatividade
Usuários inativos por mais de 90 dias devem ser marcados como inativos.

### RN03 — Limite de Tentativas de Login
Após 5 tentativas inválidas, a conta deve ser temporariamente bloqueada.

### RN04 — Cálculo de Lucro Líquido
O lucro líquido exibido na dashboard deve ser calculado como receita total menos despesas totais do período.

### RN05 — Estoque Mínimo
Cada produto deve ter um estoque mínimo definido no cadastro; ao atingi-lo, o item entra automaticamente no card de alertas da dashboard.

### RN06 — Categorias de Movimentação
Toda movimentação deve ser classificada para permitir o filtro na tela de histórico.

### RN07 — Baixa Proporcional de Insumos
Ao registrar a venda de um produto final, o sistema deve subtrair do estoque não apenas o item vendido, mas também a quantidade proporcional de insumos (tinta, papel) definida na ficha técnica do produto.

### RN08 — Preço de Custo Dinâmico
O custo de um produto final deve ser recalculado automaticamente sempre que houver alteração no preço de compra dos seus insumos vinculados.

### RN09 — Prioridade de Alerta
Produtos com estoque em "Zero" devem aparecer no topo da lista de notificações, seguidos pelos produtos que estão apenas abaixo do "Estoque Mínimo".

### RN10 — Unicidade de E-mail
Não deve ser permitido o cadastro de duas contas diferentes utilizando o mesmo endereço de e-mail.

### RN11 — Irreversibilidade de Relatórios Fechados
Após o fechamento do relatório mensal (disponibilizado na segunda-feira), as movimentações do mês anterior não podem ser editadas, apenas visualizadas, para garantir a integridade contábil.

### RN12 — Valor Mínimo de Venda
O sistema não deve permitir o registro de uma venda com valor inferior ao custo total de produção (insumos + base), a menos que o usuário confirme manualmente uma "venda com prejuízo".

### RN13 — Validação de Transcrição
Nenhuma venda enviada via comando de voz (IA) deve ser processada sem a confirmação positiva do usuário (clique no botão "Confirmar" na tela de IA Operação).

### RN14 — Sincronização de Conflitos (Modo Offline)
Caso uma alteração de estoque ocorra offline em dois dispositivos diferentes para a mesma conta, o sistema deve priorizar a alteração com o registro de data/hora (timestamp) mais recente ao restabelecer a conexão.

### RN15 — Formato de Moeda Local
Todos os cálculos e exibições de valores monetários devem seguir obrigatoriamente o padrão da moeda local (BRL - R$), com duas casas decimais.
