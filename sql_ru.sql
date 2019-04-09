6.select p.maker,l.speed
 from product p,laptop l
on l.model=p.model
where(l.hd>10)

select maker from product where
 model in
(select model from laptop where hd>10)
7. 
select model, price from pc where model in
(select p.model, from product p where maker='B')
union all
select model,price from laptop where model in
(select p.model, from product p where maker='B')
union all
select model,price from printer where model in
(select p.model, from product p where maker='B')

8.
select distinct maker from product where type='pc'
and 
maker not in
(select maker from product where type='laptop')
9.
select distinct maker from product where type='pc'
and model in(select model from pc where speed >=450 )
10.
select model,price from printer
 where price=(select max(price) from printer)
11.
select avg(speed) from laptop
where price>=1000;


13.
select avg(speed) from pc where model in (
	select model from product where type='pc' and maker='A'
)
14.
select maker,type
 from product 
 group by type
 having count(model) >1

15.
select hd from pc
gro up by hd
having count(hd)>=2

16.
select a.model from pc a,
select b.model from pc b
group by a.model
having  (count(a.speed)>1 and count(ram)>1 and a.model>b.model)

17.
select distinct p.type,l.model ,l.speed 
from laptop l
left join
 product p
on l.model=p.model
where l.speed<all(select speed from pc)

 18.
select distinct a.maker ,b.price
from product a
left join
printer b
on a.model=b.model
where b.price=(select min(price) from printer where color='y' )  and b.color='y'


--------------------------
select b.maker , a.priceA price from(select model, min(price) priceA
   from printer 
group by model,color
having color='y' ) a
inner join 
product b 
on a.model=b.model
-----------------------

select c.maker,c.priceA from
(
select b.maker, a.price priceA,a.model,a.color from (select * from printer
 where price = ( select min (price)  from printer  where color='y'))a
inner join product b
on a.model=b.model)
c where c.color='y'

19
select a.maker,avg(b.screen)
 from    product a
inner join 
laptop b
on a.model=b.model
where a.type='laptop'
group by a.maker
20.
select maker,count(maker) from product
 where type='pc'
group by maker
having count(maker)>=3

21.

select a.maker,max(c.price) from product a 
inner join
pc c on a.model=c.model
where exists(select  b.price from pc b where b.model=a.model
)
group by a.maker

22.

Select a.speed,avg(b.price) avg_price from pc a 
left join
pc b on a.speed=b.speed
where a.speed > 600
group by a.speed

23.

select x.maker
 from product x
  left join
pc y
on x.model=y.model and y.speed >=750
 where type= 'pc' and maker in
(select a.maker   from product a where  type='pc'
intersect
select b.maker  from product b where  type='laptop'
)
union 
select x.maker
 from product x
  left join
laptop y
on x.model=y.model and y.speed >=750
 where type= 'laptop' and maker in
(select a.maker   from product a where  type='pc'
intersect
select b.maker  from product b where  type='laptop'
)
24.
WITH Common_Max_Price AS (select model,price from pc where 
price=(select max(price) from pc)
union
select model,price from printer where 
price=(select max(price) from printer )
union
select model,price from laptop where 
price=(select max(price) from laptop)
)select model from Common_Max_Price 
where price=(select max(price) from Common_Max_Price )

25.

select b.maker,a.model,a.ram,max(a.speed) from 

(select speed,  model,ram from pc 
where ram=(select min(ram) from pc))
a
left join
product b
on a.model=b.model


group by b.maker,a.model,a.ram

26.
select avg(x.price ) from (
select  a.price,b.model 
from pc a
left join product b
on a.model=b.model
 where b.type='pc'and b.maker='A'
union all
select c.price,c.model from
 laptop c
left join  product d
on c.model=d.model
 where d.type='laptop' and d.maker='A'

)x

27.
select a.maker,avg(c.hd)  from product a 
left join product b on a.maker=b.maker 
left join  pc c
on a.model=c.model
where (a.type='pc' and b.type='printer')
group by a.maker

28.
select count(maker) 
from 
(select maker from product a 
group by maker 
having count(maker) =1)b

36.


37.
select c.class,count(o.ship) from classes c
left join outcomes o
on c.class=o.ship
left join ships s
on c.class=s.class
group by c.class,s.class,s.name
having count(o.ship)=1
union
select c.class,count(s.name)
from classes c
left join ships s
on c.class=s.class
group by c.class
having count(s.n,ame)=1

--------------------------
select s.class from ships s
group by s.class
having count(s.name)=1
union
select c.class from classes c
left join 
outcomes o
on c.class=o.ship
where o.ship  not in(
select name  from ships s
)



38.
select country from classes where type='bb'
intersect
select country from classes where type='bc'


40.
select a.class,a.name,b.country
from
ships a left join
classes b
on a.class=b.class
where b.numGuns>=10

44.
select o.ship from outcomes o 
 where o.ship like 'R%' 
union 
select name from ships s
where s.name like 'R%'


45.
select o.ship from outcomes o 
 where o.ship like '% % %' 
union 
select name from ships s
where s.name like '% % %'

46.
select  s.name,c.displacement,c.numGuns
from classes c
left join
ships s
on c.class=s.class
left join outcomes o
on o.ship=s.name
where o.battle='Guadalcanal'
union  
select  c.class,c.displacement,c.numGuns
from classes c
left join outcomes o
on o.ship=c.class
where o.battle='Guadalcanal'

48.

select c.class  from classes c
left join ships s on c.class=s.class
left join outcomes o on s.name=o.ship
where o.result='sunk'
group by c.class
having count(o.ship)>0
union 
select c.class
 from classes c
left join outcomes o on c.class=o.ship
where o.result='sunk'
group by c.class
having count(o.ship)>0

49.
select s.name from ships s
left join  classes c 
on c.class=s.class where c.bore=16
union 
select o.ship from outcomes o
left join classes c on o.ship=c.class
where c.bore=16


50.
select o.battle from
outcomes o
left join 
ships s
on o.ship=s.name
where s.class='kongo'

56.
select s.class,o.ship,count(o.result)
 from ships s
left join outcomes o on o.ship=s.name
where o.result='sunk'
group by s.class,o.ship
union 
select c.class,o.ship,count(o.result)
 from classes c
left join outcomes o on o.ship=c.class
where o.result='sunk'
group by c.class,o.ship


57.
select c.class  , count(o.ship)
from outcomes o
left join ships s
on o.ship = s.name
left join classes c on s.class=c.class
 where result ='sunk' and s.class in
 (
select class as count from ships  
group by class
having count(name)>=3
)
group by c.class 
having count(o.ship) > 0
