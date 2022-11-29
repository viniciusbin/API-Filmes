Teste Dimensa - Aplicativo baseado na API TheMovieDB.

![460x0w](https://user-images.githubusercontent.com/107441911/204406428-cbd91f24-0d8f-4243-a427-dd220f8f952d.png)

(Tela utilizada na réplica)

Requisitos

1. As informações do filme devem vir do endpoint getMovieDetails.
2. Usar o <vote_count> que retorna da API para representar o número de likes.
3. Substituir o “3 of 10 watched” por “<popularity> views”, utilizando o valor retornado da API.
4. Formatar os todos os valores numéricos apresentados por milhar e milhão. Exemplos: 4659 -> 4.6k e
2392182 -> 2.3M.
5. O ícone de like (coração) deve mudar quando clicado, alternando entre preenchido e vazio.
6. Deve haver uma lista de filmes abaixo dos detalhes (essa lista deve ser o retorno da getSimilarMovies).
  
Sugestões
  
1. Montar o projeto usando UIKit.
2. Utilizar ViewCode para elaborar as Views (com constraints do NSLayoutConstraint ou SnapKit).
3. Fazer uso de uma arquitetura definida. Preferencialmente MVVM ou MVVM-C.
4. Aplicar programação reativa com o RxSwift.
5. Implementar testes no projeto, como unitários, de UI ou de Snapshot.
  
  Projeto finalizado.
  
  
![Captura de Tela 2022-11-28 às 21 11 56](https://user-images.githubusercontent.com/107441911/204407205-904c066d-ce87-427e-a543-e6148de5d262.png)

  Todos os requisitos foram feitos na implementação deste projeto. Arquitetura usada foi o MVVM, os dados do filme e a lista de filmes similares são obtidos nos endpoints da API. Utilizei todos os frameworks nativos para requisição da API, autolayout e componentização. 
Das sugestões, não apliquei RXSwift, pois está no meu roadmap de aprendizado. Testes de snapshot, eu conheço e já apliquei em um projeto de tela simples, mas preferi não implementar, pois não domino.
  
  Considerações finais.
  
  Foi o desafio mais interessante que ja fiz até hoje, pude utilizar dos meus aprendizados de lógica, e também aprender novas implementações.
  Como recado ao avaliador, sempre sou muito determinado e nunca desisto de encontrar a solução de problemas e de novos desafios. 
  Obrigado pela oportunidade.
  
Até!
