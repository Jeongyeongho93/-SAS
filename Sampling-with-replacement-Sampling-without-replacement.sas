/복원추출로 로또 데이터 정제/ 
data lotto mj; do j=1 to 100000; 
do i=1 to 6; lon=45*ranuni(-1); 
lotto=round(lon); output; 
end;

end; 

rename j=event i=ball; 
drop lon; 
run;

/비복원추출로 로또 데이터 정제/ /method = 에서 SRS을 URS로 변경하면 복원추출로 됨/ 

data num; 
do i=1 to 45; 
output; end; run;

proc surveyselect data = num method = SRS rep = 10000 sampsize = 6 seed = 342672 out = a; 
run; 

proc print data = lotto(obs=100) noobs; 
run;

/data step을 이용한 비복원추출 방식/ 

data mj; 
do j=1 to 10000; 
y1 = 0; y2= 0; y3=0; y4=0; y5=0; do i=1 to 6; 
a: lon=45*ranuni(100); y=ceil(lon); 
if (y=y1 or y=y2 or y=y3 or y=y4 or y=y5 ) then goto a; 
else output; 
y5=y4; y4=y3; y3=y2; y2=y1; y1=y; 
end; 
end; 
run;

proc freq data mj noprint; by j; 
table=y out=freq; 
run;

proc print data=freq; 
where count ne 1; 
run;
