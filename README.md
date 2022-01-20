# T-SQL + RPG

* Execute os .sql se acordo com a ordem estabelecida 

* Os Scripts / Procs que se iniciam com "999" não são obrigatórios para a criação da base, mas é neles que está a diversão! (use-os somente ao término da criação de toda estrutura)

## Modo Batalha

Antes de tudo execute a proc e gere pelo menos dois personagens, exemplo:

~~~tsql
exec sp_gera_personagem
~~~

Para realizar uma batalha primeiro escolha dois personagens e pegue seus códigos, depois é só rodar a Procecure de batalha, exemplo:

~~~tsql
exec sp_batalha 15, 18 
~~~

Neste exemplo, foram utilizados os personagens "15" e "18".

### Cálculos da batalha

É rolado o dado referente a arma que o personagem tem e gera-se um valor de Ataque.

Subtraímos deste valor quanto de defesa na Armadura o outro personagem tem.

Desse valor resulta o Dano, que tiramos do Ponto de Vida (PdV) do personagem atacado.

> Resumindo:
> Dano = Ataque - Defesa
> PdV = PdV - Dano

Quem tiver primeiro seus PdV zerados, morre e o outro personagem vence.

* Caso existe um Erro Crítico (1) ou um Dano Crítico (máximo do dado de ataque), uma mensagem é exibida.

* Caso a Defesa de um personagem seja maior que o ataque do oponente, uma mensagem de Defesa é exibida.

## Rolar Dados

Proc que serve somente como diversão, escolha quando dados e quantos lados e execute! Por exemplo, para rolar 2d10 use:

~~~tsql
exec sp_rolar_dados 2, 10 
~~~

## Referências utilizadas

https://dnd5ed.github.io/livros/LDJ.pdf

https://www.helprpg.com.br/2018/07/armas-armaduras-e-equipamentos-d-5e.html

https://hablamosdegamers.com/pt/guia/nomes-para-personagens/#Nomes-medievais-para-RPG

https://jogaod20.com/2020/05/08/tabela-acertos-criticos/

https://abcdorpg.com/classes-do-rpg-medieval/

https://dndbrasil.fandom.com/

https://rpgmaisbarato.com/blog/assets/upload/artigos/racas-talentos-dnd-5.pdf


