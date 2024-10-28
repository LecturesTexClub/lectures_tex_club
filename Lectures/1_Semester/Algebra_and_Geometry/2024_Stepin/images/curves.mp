input TEX;
input Pack/cmarrows/cmarrows;
defaultscale := 1.5pt;


setup_cmarrows(
brace_name = "extensiblebrace";
parameter_file = "cmr9.mf";
macro_name = "bracea");

setup_cmarrows(
arrow_name = "texarrow";
parameter_file = "cmr10.mf";
macro_name = "arrowa");

u:=5mm;
s:=u;
d:=40u;
e:=d;
tt:= sqrt 2;

marksize=.2*u;
def draw_mark(expr p, a) =
begingroup
save t, dm; pair dm;
t = arctime a of p;
dm = 2.7marksize*unitvector direction t of p
rotated 90;
draw (-.5dm.. .5dm) shifted point t of p;
endgroup
enddef;



def draw_marked(expr p) =
begingroup
save amid;
amid = .5*arclength p;
for i=-(n-1)/2 upto (n-1)/2:
draw_mark(p, amid+1.45marksize*i);
endfor
draw p dashed dash;
endgroup
enddef;

def draw_vector(expr B, A) =
pair f!, g!;
f! = A + dir(angle(B-A) + 30)*.3*u;
g! = A + dir(angle(B-A) - 30)*.3*u;
draw f!--A--g!;
draw B--A;
enddef;

def draw_vector_dashed(expr B, A, pic) =
pair f!, g!;
f! = A + dir(angle(B-A) + 30)*.3*u;
g! = A + dir(angle(B-A) - 30)*.3*u;
draw f!--A--g!;
draw B--A dashed pic;
enddef;

def draw_angle(expr B, A, C,b,n,k) =
begingroup
path p[]; 
pair S[],T[],Q[];
for i = 1 upto n:
S[i] = A + dir(angle(B-A))*k*(1+i*.5)*u; 
T[i] = A + dir(angle(C-A))*k*(1+i*.5)*u;
if abs(angle(B-A) - angle(C-A)) < 180:
Q[i] = A + dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1+i*.5)*u;
else:
Q[i] = A - dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1+i*.5)*u;
fi;
p[i] = S[i]..Q[i]..T[i];
draw p[i];
endfor
x := round(abs(angle(B-A)-angle(C-A)));
if b: 
t := angle(Q[n]-A);
picture laba; 
laba = thelabel(TEX("${" & decimal(x) & "}^\circ$"), (Q[n] + .7u*dir(t)));
fill bbox laba withcolor white;
draw laba;
fi;
endgroup
enddef;

def draw_f_angle(expr B, A, C,k) = 
begingroup
path p!; 
pair S!,T!,Q!;
S! = A + dir(angle(B-A))*k*(1.5)*u; 
T! = A + dir(angle(C-A))*k*(1.5)*u;
if abs(angle(B-A) - angle(C-A)) < 180:
Q! = A + dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1.5)*u;
else:
Q! = A - dir(1/2*angle(B-A)+1/2*angle(C-A))*k*(1.5)*u;
fi;
p! = S!..Q!..T!--A--cycle;
fill p! withcolor black;
x := round(abs(angle(B-A)-angle(C-A)));
endgroup
enddef;

def draw_h(expr A,B,C,k) =
pair H!,x[];
H! = whatever[B,C] = A + whatever*dir(angle(B-A)+90-angle(A-B)+angle(C-B));
path p,a;
p := A--H!;
x1 = H! + k*u*dir(angle(A-H!));
x2 = H! + k*u*dir(angle(B-H!));
x3 = x1 + k*u*dir(angle(B-H!)) ;
a := x1--x3--x2;
draw p;
draw a;
enddef;

vardef h(expr A,B,C) = 
pair H!;
H! = whatever[B,C] = A + whatever*dir(angle(B-A)+90-angle(A-B)+angle(C-B));
H!
enddef;

vardef circdef(expr A,B,C) = 
pair N!,M!,O!;
M! = 1/2[A,B]; N! = 1/2[C,B];
O! = M! + whatever*dir(angle(A-B) - 90) = N! + whatever*dir(angle(C-B) + 90);
path p;
p := fullcircle scaled (2*arclength(O!--A)) shifted (O!);
p
enddef;

vardef incirc(expr A,B,C) = 
pair I!,H!;
I! = A + whatever*dir(1/2*angle(B-A)+1/2*angle(C-A)) = C + whatever*dir(1/2*angle(B-C)+1/2*angle(A-C));
H! = h(I!,A,B);
path p;
p := fullcircle scaled (2*arclength(I!--H!)) shifted I!;
p
enddef;


vardef cent(expr c) = 
pair a!,b!,q!,o!,m!,n!;
a! = point .1 of c;
b! = point .2 of c;
q! = point .3 of c;
m! = 1/2[a!,b!]; n! = 1/2[q!,b!];
o! = m! + whatever*dir(angle(a!-b!) - 90) = n! + whatever*dir(angle(q!-b!) + 90);
o!
enddef;


vardef tangent(expr A,o,sgn) = 
pair p!,M!,v!;
p! = cent(o);
M! = 1/2[A,p!];
path c!;
c! = halfcircle scaled (arclength(A--p!)) rotated(90 + 90* sgn + angle(A-p!)) shifted M!;
v! = c! intersectionpoint o;
draw A--v!;
v!
enddef;

beginfig(1);
pair A,B,C,D,E,X,Y,K,L,M;

numeric a, b, c,d,e;
a = 4; b = 4;
c = sqrt(2)*4;
d = a*a/c;
e = c/a;

draw (20u,20u)--(-20u,-20u);
draw (-20u,20u)--(20u,-20u);

pair r[];
for x=0 upto 4:
r[x] = (a*u*(5 - x), u*sqrt(b*b*(5-x)*(5-x) - b*b));
endfor;

for x=5 upto 8 :
r[x] = (a*u*(x - 3), -u*sqrt(b*b*(3-x)*(3-x) - b*b)); endfor;

draw r[0] for i=1 upto 8: ..r[i] endfor;

pair l[];
for x=0 upto 4:
l[x] = (-a*u*(5 - x), u*sqrt(b*b*(5-x)*(5-x) - b*b));
endfor;

for x=5 upto 8 :
l[x] = (-a*u*(x - 3), -u*sqrt(b*b*(3-x)*(3-x) - b*b)); endfor;

draw l[0] for i=1 upto 8: ..l[i] endfor;

pickup pencircle scaled 2pt;
draw_vector((0,-20u),(0,20u));
draw_vector((-20u, 0),(20u,0));

pickup pencircle scaled 1pt;
draw (d*u,-20u)--(d*u,20u) dashed evenly scaled 2;
draw (-d*u,-20u)--(-d*u,20u) dashed evenly scaled 2;

dotlabel.urt(TEX("$F_1$"), (0,0)) scaled 2 shifted (c*u,0);
dotlabel.ulft(TEX("$F_2$"), (0,0)) scaled 2 shifted (-c*u,0);

A = r[2];
draw A--(c*u,0);
draw A--(-c*u,0);
B = h(A, (d*u,0), (d*u,1));
draw_h(A, (d*u,0), (d*u, 1*u), .5);
dotlabel.lrt(TEX("$A$") scaled 2, A);
endfig;


beginfig(2);
pair A,B,C,D,E,X,Y,K,L,M;

numeric a, b, c,d,e,x;
a = 12; b = 6;
c = sqrt(a*a-b*b);
d = a*a/c;
e = c/a;

pair r[];
for x=0 upto 4:
r[x] = (a*u*x/4, u*b*sqrt(1 - (x*x/16)));
endfor;

for x=5 upto 8 :
r[x] = (a*u*(8-x)/4, -u*b*sqrt(1 - ((8-x)*(8-x)/16)));
endfor;

draw r[0] for i=1 upto 8: ..r[i] endfor;

pair l[];
for x=0 upto 4:
l[x] = (-a*u*x/4, u*b*sqrt(1 - (x*x/16)));
endfor;

for x=5 upto 8 :
l[x] = (-a*u*(8-x)/4, -u*b*sqrt(1 - ((8-x)*(8-x)/16)));
endfor;

draw l[0] for i=1 upto 8: ..l[i] endfor;

pickup pencircle scaled 2pt;
draw_vector((0,-20u),(0,20u));
draw_vector((-20u, 0),(20u,0));

pickup pencircle scaled 1pt;
draw (d*u,-20u)--(d*u,20u) dashed evenly scaled 2;
draw (-d*u,-20u)--(-d*u,20u) dashed evenly scaled 2;

dotlabel.llft(TEX("$F_1$"), (0,0)) scaled 2 shifted (c*u,0);
dotlabel.lrt(TEX("$F_2$"), (0,0)) scaled 2 shifted (-c*u,0);

A = r[2];
draw A--(c*u,0);
draw A--(-c*u,0);
B = h(A, (d*u,0), (d*u,1));
draw_h(A, (d*u,0), (d*u, 1*u), .5);
dotlabel.top(TEX("$A$") scaled 2, A);
endfig;
end;

