# SO.2016.2
Trabalho de Sistemas Operacionais - IFCE - Campus Benfica - 2016.2 - Professor Fernando Parente
Desenvolvido por: Clinton de Sá, Daniel Bernardo e Rui Moreno.

## Objetivo 
Desenvolver uma aplicação que utilize de Semáforos para resolver uma situação problema.

### Situação problema
Imagine `N` crianças que estão, a princípio, quietas. `M` crianças (`M` < `N`) inicialmente possuem uma bola e as outras, não. 
De repente, sentem vontade de brincar com uma bola. Com esse desejo incontrolável, as que já estão com a bola 
simplesmente brincam. As que não têm bola correm ao cesto de bolas, que está inicialmente vazio e que suporta até `K`
bolas. Se o cesto possuir bolas, uma criança pega a bola e vai brincar feliz. Se o cesto estiver vazio, ela fica esperando 
até que outra criança coloque uma bola no cesto. Quando uma criança termina de brincar, ela tem que colocar a bola no 
cesto, mas se o cesto já estiver cheio, ela segura a bola até que outra criança retire uma bola que já está no cesto, e
então solta sua bola no cesto e volta a ficar quieta. Admita que as crianças continuem brincando e descansando (quieta)
eternamente. Utilizando semáforos, modele esseproblema resolvendo os conflitos entre os `N` threads "criança". 

### Entrada do programa
* Capacidade do cesto de bolas (`K`).
* Criação do thread criança:
  A aplicação deve possuir um botão para que o usuário possa criar uma criança aqualquer momento. Durante a criação de 
  cada thread criança, os seguintes parâmetros devem ser definidos:
    * Id = identificador da criança (número ou nome).
    * Bola? = define se a criança será instanciada com bola ou sem bola.
    * Tb = tempo de brincadeira (tempo que a criança fica brincando com a bola – a criança não deve dormir durante
    este tempo).
    * Tq = tempo quieta (tempo que criança fica quieta após colocar a bola no cesto – a criança não deve dormir 
    durante este tempo).
   
### Saída do programa
A interface deverá atender aos seguintes requisitos:
* Mostrar os dados de cada criança: identificador, tempo de brincadeira e tempo que fica
quieta.
* Mostrar, a cada instante, o status de cada thread criança (brincado com a bola,
aguardando que outra criança coloque uma bola no cesto, aguardando que o cesto tenha
espaço para que ela coloque sua bola ou quieta).
* Mostrar um log com os principais eventos de cada criança

## Desenvolvimento
A aplicação foi desenvolvida em Swift 3 com a interface sem considerar constraints e voltada para o iPad Air.

##Demo
![alt tag](https://github.com/clintonsbm/SO.2016.2/blob/master/Demo/ezgif.com-gif-maker.gif)
