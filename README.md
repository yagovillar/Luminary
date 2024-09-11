# Luminary

**Luminary** é um aplicativo de reprodução de podcasts, desenvolvido em Swift, com foco em fornecer uma interface fluida e simples para os usuários navegarem e ouvirem episódios de seus podcasts favoritos. O app inclui funcionalidades avançadas de controle de áudio e navegação, utilizando componentes personalizados como PlayerView e TabBarPlayerView.

## Funcionalidades

- **Reprodução de Podcasts**: Permite aos usuários navegar por episódios e reproduzi-los com controles completos.
- **Seção de Episódios**: Lista todos os episódios disponíveis de um podcast, com navegação para a página de reprodução.
- **Controle de Áudio**: Inclui controles de áudio integrados ao sistema com suporte a play/pause e progresso.
- **Design Customizado**: UI moderna usando SwiftUI, com ViewCode para componentes reutilizáveis e um design responsivo.
- **PlayerView e TabBarPlayerView**: Utiliza uma interface compacta de player na barra inferior que expande para um player de tela cheia quando necessário.

## Tecnologias Utilizadas

- **Swift** e **SwiftUI** para desenvolvimento da interface de usuário.
- **Combine** para gerenciamento de estado e observação de mudanças.
- **AVKit** para controle de áudio.
- **SwiftData** para gerenciar e persistir dados localmente.
- **MVVM-C** (Model-View-ViewModel-Coordinator) como arquitetura para separar responsabilidades e gerenciar a navegação.

## Estrutura do Projeto

- **Model**: Representa os dados e estruturas como `Podcast` e `Episode`.
- **ViewModel**: Gerencia a lógica de negócios e a interação entre as views e os serviços, como a obtenção de dados do serviço de podcasts.
- **Views**: Interfaces de usuário, incluindo componentes como `DetailsView`, `PlayerView` e `TabBarPlayerView`.
- **Coordinator**: Gerencia a navegação entre as diferentes telas e fluxos de usuário.

## Instalação

1. Clone o repositório:
    ```bash
   git clone https://github.com/usuario/luminary.git
    ```

2. Navegue até o diretório do projeto.
   

3. Instale as dependências com Cocoapods:
    ```bash
    pod install
    ```

4. Abra o projeto no Xcode usando o arquivo `.xcworkspace`:
    ```bash
    open Luminary.xcworkspace
    ```

5. Compile e execute o aplicativo no Xcode.

---
