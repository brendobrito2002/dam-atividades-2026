# ESPECIFICAÇÃO DO PROJETO BASE FLUTTER: "Vendas App"

Você é um Engenheiro de Software especializado em Flutter. Seu objetivo é gerar o código-fonte de um projeto starter completo chamado "Vendas App". O projeto é voltado para fins acadêmicos e deve ser desenvolvido de forma modular, limpa e desacoplada, servindo como base para que alunos de desenvolvimento mobile implementem tarefas práticas de UI.

---

## 1. REQUISITOS TECNOLÓGICOS E ARQUITETURAis

- **Framework:** Flutter (versão estável mais recente, compatível com Dart 3.x).
- **Gerência de Estado:** Provider (através do pacote `provider`).
- **Persistência de Dados Local:** Em memória (In-memory, mantido de forma volátil durante a execução do aplicativo).
- **Padrão de Arquitetura:** MVVM com Repositories e DataSources locais de forma desacoplada.
- **Estilo Visual:** Tema escuro ou tema vibrante (Indigo/Orange), limpo e consistente.

---

## 2. ESTRUTURA DE DIRETÓRIOS DO PROJETO

Gere os arquivos seguindo rigorosamente a estrutura abaixo:

```text
lib/
├── main.dart
├── src/
│   ├── app.dart                          # MaterialApp, Rotas e Configuração do Tema
│   ├── models/                           # Entidades de Domínio
│   │   ├── client_model.dart
│   │   ├── product_model.dart
│   │   └── order_model.dart
│   ├── data/
│   │   ├── datasources/
│   │   │   └── local/
│   │   │       ├── client/
│   │   │       │   ├── client_local_datasource.dart
│   │   │       │   └── client_memory_local_datasource.dart # Implementação em memória
│   │   │       ├── product/
│   │   │       │   ├── product_local_datasource.dart
│   │   │       │   └── product_memory_local_datasource.dart # Catalogo semeador em memória
│   │   │       └── order/
│   │   │           ├── order_local_datasource.dart
│   │   │           └── order_memory_local_datasource.dart # Pedidos em memória
│   │   └── repositories/
│   │       ├── client/
│   │       │   ├── client_repository.dart
│   │       │   └── client_repository_impl.dart
│   │       ├── product/
│   │       │   ├── product_repository.dart
│   │       │   └── product_repository_impl.dart
│   │       └── order/
│   │           ├── order_repository.dart
│   │           └── order_repository_impl.dart
│   ├── viewmodels/                       # ChangeNotifiers (Controllers do Provider)
│   │   ├── client_viewmodel.dart
│   │   ├── product_viewmodel.dart
│   │   ├── cart_viewmodel.dart           # Controller do carrinho de compras ativo
│   │   └── order_viewmodel.dart          # Controller do histórico de pedidos realizados
│   └── views/                            # Interface de Usuário
│       ├── home/
│       │   └── home_page.dart            # Menu com 3 botões (Clientes, Produtos, Pedidos) e FAB extensível "Novo pedido"
│       ├── client/
│       │   ├── client_list_page.dart     # Tela de listagem de clientes
│       │   └── form/
│       │       └── client_form_page.dart # Formulário de cadastro de clientes com validação
│       ├── product/
│       │   ├── product_list_page.dart    # Tela de catálogo/listagem de produtos
│       │   └── form/
│       │       └── product_form_page.dart # Formulário de cadastro de novos produtos
│       └── order/
│           ├── order_list_page.dart      # Tela de histórico de pedidos realizados
│           ├── cart/
│           │   └── cart_page.dart        # Tela do carrinho de compras (criação de novo pedido)
│           └── detail/
│               └── order_detail_page.dart # Tela de detalhes de um pedido finalizado
assets/
└── images/
    └── placeholder_product.png           # Adicionar referência estática para fallback
```

---

## 3. DADOS INICIAIS EM MEMÓRIA (Memory Seeding)

As implementações de DataSources em memória (`client_memory_local_datasource.dart` e `product_memory_local_datasource.dart`) devem conter listas mutáveis locais contendo dados iniciais mockados para que a aplicação não inicie vazia. Se o aplicativo for reiniciado, o estado é resetado.

### Clientes Iniciais
- **João Silva** (Telefone: `(11) 98888-8888`, Endereço: `Rua das Flores, 123`)
- **Maria Souza** (Telefone: `(21) 97777-7777`, Endereço: `Av. Atlântica, 456`)

### Catálogo de Produtos Inicial (Pelo menos 5 produtos com URLs de imagens do Unsplash):
- **Hambúrguer Gourmet** (Preço: 25.90, Categoria: "Comidas", Imagem: `https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500`, isFavorite: false)
- **Batata Frita** (Preço: 12.00, Categoria: "Comidas", Imagem: `https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500`, isFavorite: false)
- **Refrigerante de Cola** (Preço: 6.00, Categoria: "Bebidas", Imagem: `https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500`, isFavorite: false)
- **Suco Natural** (Preço: 8.00, Categoria: "Bebidas", Imagem: `https://images.unsplash.com/photo-1536882240095-0379873feb4e?w=500`, isFavorite: false)
- **Milkshake de Chocolate** (Preço: 15.00, Categoria: "Sobremesas", Imagem: `https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500`, isFavorite: false)

---

## 4. ESPECIFICAÇÃO DE CÓDIGO POR CAMADA (A SER GERADO)

### A. Camada de Models (`models/`)
Gere os arquivos `client_model.dart`, `product_model.dart` e `order_model.dart` com seus respectivos construtores e métodos de conversão `fromMap` e `toMap`.
- No `order_model.dart`, defina a classe `CartItem` (que encapsula um `ProductModel` e sua quantidade inteira `quantity`) e a classe `OrderModel`.
- No `OrderModel`, a associação de cliente (ex: `clientId` e `clientName`) deve ser opcional (permitindo criar pedidos sem associar um cliente). A lista de itens do pedido deve ser composta de objetos `CartItem`.

### B. Camada de DataSources (`data/datasources/local/`)
Gere as classes abstratas (contratos) e suas respectivas implementações em memória (in-memory) organizadas em subpastas por entidade/domínio. Cada implementação deve gerenciar uma lista estática/local mutável.
- `client/client_local_datasource.dart` & `client/client_memory_local_datasource.dart`: Contrato e implementação em memória para o CRUD de clientes.
- `product/product_local_datasource.dart` & `product/product_memory_local_datasource.dart`: Contrato e implementação em memória para o catálogo e cadastro de produtos (CRUD, filtros e favoritos).
- `order/order_local_datasource.dart` & `order/order_memory_local_datasource.dart`: Contrato e implementação em memória para o CRUD de pedidos.

### C. Camada de Repositories (`data/repositories/`)
Gere as classes abstratas (contratos) e implementações concretas organizadas em subpastas por entidade/domínio.
- `client/client_repository.dart` & `client/client_repository_impl.dart`: Contrato e implementação do repositório de clientes.
- `product/product_repository.dart` & `product/product_repository_impl.dart`: Contrato e implementação do repositório de produtos.
- `order/order_repository.dart` & `order/order_repository_impl.dart`: Contrato e implementação do repositório de pedidos.

### D. Camada de ViewModels (`viewmodels/`)
Implemente as quatro classes `ChangeNotifier`:
- `ClientViewModel`: Carrega e gerencia o cadastro e a lista de clientes.
- `ProductViewModel`: Gerencia a lista de produtos. Adicione métodos para cadastrar/salvar novos produtos no catálogo, além de filtrar por categoria localmente, alternar favoritos e ordenar os produtos.
- `CartViewModel`: Gerencia o carrinho de compras ativo (único) em memória.
  - **Carrinho Ativo (Único):** Deve manter em memória o estado do carrinho atual composto por uma lista de `CartItem`, o cliente atualmente selecionado (ex: `ClientModel? selectedClient` - opcional) e o valor total do carrinho.
  - **Ações do Carrinho:** Métodos para adicionar produto (`addToCart`), remover produto (`removeFromCart`), atualizar quantidade (`updateQuantity`), selecionar/limpar cliente e limpar o carrinho inteiro (`clearCart`).
  - **Finalização:** Método `checkout` que converte o carrinho ativo em um `OrderModel` definitivo, salva-o (via `OrderRepository` ou chamando `OrderViewModel`) e limpa o estado do carrinho ativo para que um novo pedido possa ser iniciado.
- `OrderViewModel`: Gerencia a lista de histórico de pedidos finalizados carregados do `OrderRepository` e expõe métodos de ordenação e visualização dos dados para a listagem.

### E. Camada de Views (`views/`)
Gere as telas do aplicativo utilizando componentes limpos do Flutter.
- `home/home_page.dart`: Menu principal do aplicativo contendo 3 botões estilizados para navegar até as telas de Clientes, Produtos e Pedidos. Inclui também um `FloatingActionButton.extended` para "Novo Pedido" que inicia o fluxo de criação de pedidos.
- `client/client_list_page.dart`: Tela de listagem de clientes.
- `client/form/client_form_page.dart`: Tela de cadastro/edição de clientes com validação.
- `product/product_list_page.dart`: Tela de catálogo de produtos com Grid/List e opção de favoritos.
- `product/form/product_form_page.dart`: Tela de cadastro de novos produtos para o catálogo com validação.
- `order/order_list_page.dart`: Tela que mostra o histórico de pedidos já finalizados.
- `order/cart/cart_page.dart`: Tela do carrinho de compras (novo pedido). Permite visualizar e alterar os itens e quantidades do carrinho ativo, selecionar cliente (opcional) e finalizar o pedido (checkout).
- `order/detail/order_detail_page.dart`: Tela de visualização detalhada de um pedido já realizado, exibindo data, informações do cliente, total geral e a lista detalhada de produtos adquiridos.

---

## 6. Verificação e Qualidade
Garanta que todos os arquivos criados compilem limpos no ecossistema Dart/Flutter e utilizem nomenclatura estritamente em português para os componentes visuais, preservando as interfaces limpas e o desacoplamento arquitetural.
