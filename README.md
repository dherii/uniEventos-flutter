# 🎓 UniEventos App

[cite_start]O **UniEventos** é uma aplicação mobile desenvolvida em Flutter para facilitar a visualização e inscrição em eventos acadêmicos, como palestras, workshops e hackathons[cite: 4]. [cite_start]O foco principal do projeto foi a criação de uma interface performática, coesa e funcional para a comunidade universitária[cite: 5, 20].

## 🚀 Funcionalidades Principais

* [cite_start]**Catálogo de Eventos:** Visualização de centenas de eventos acadêmicos em uma lista otimizada[cite: 5, 18].
* [cite_start]**Gestão de Favoritos:** Sistema interativo que permite favoritar eventos diretamente no card[cite: 30, 32].
* [cite_start]**Inscrição Rápida:** Formulário integrado para participação com validações de segurança[cite: 25, 28].
* [cite_start]**Detalhes Completos:** Tela dedicada com informações detalhadas extraídas via argumentos de rota[cite: 23, 24, 39].

## 🛠️ Desafios Técnicos Superados

[cite_start]Este projeto foi desenvolvido como parte de uma recuperação de nota, focando em práticas avançadas de desenvolvimento[cite: 2]:

* [cite_start]**Performance (ListView.builder):** Implementação de renderização eficiente para lidar com grandes volumes de dados (Mock de 50+ eventos) sem perda de quadros[cite: 9, 15, 37, 40].
* [cite_start]**Arquitetura de Navegação:** Uso de **Named Routes** no `MaterialApp` para uma transição de telas organizada e escalável[cite: 10, 22, 42].
* [cite_start]**Modelagem de Dados:** Estruturação da classe `Evento` utilizando **construtores nomeados** em Dart[cite: 8, 14].
* [cite_start]**Robustez de Formulários:** Validação rigorosa de inputs (E-mail e Nome) utilizando `GlobalKey<FormState>`[cite: 11, 29, 41].
* [cite_start]**Ciclo de Vida:** Gerenciamento de memória com a implementação correta do método `dispose()` para controladores de texto[cite: 43].
* [cite_start]**Adaptabilidade:** Uso de Widgets Adaptativos para garantir uma experiência consistente em diferentes plataformas[cite: 36].

## 🎨 Identidade Visual

[cite_start]O app utiliza o padrão de cores `#FF7518` (Laranja Universitário) definido via `ThemeData`, garantindo uma interface profissional e coesa em todos os componentes[cite: 5, 20].

## 📦 Como rodar o projeto

1. [cite_start]Certifique-se de ter o Flutter SDK atualizado instalado[cite: 35].
2. Clone o repositório.
3. Execute `flutter pub get` para instalar as dependências.
4. Rode o app com `flutter run`.
