%% sgbx0019.mp
%% Copyright 2006 Tommy Ekola <tek@kth.se>
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3 of this license
% or (at your option) any later version.  The latest version of this
% license is in http://www.latex-project.org/lppl.txt
%
% This work has the LPPL maintenance status `maintained'.  The Current
% Maintainer of this work is Tommy Ekola.  The Base Interpreter is
% MetaPost.

vardef setup_righthalfarrow (expr source_file, cmdname) =

  scantokens ("input tgbx0000");

  scantokens ("input " & source_file);

  expandafter def scantokens cmdname expr p =
    scantokens (cmdname & "__sgbxww")(p)
  enddef;

  expandafter vardef scantokens (cmdname & "__sgbxww " & "(expr apth) " &
    "text text_ = " &

    "save math_spread, x_height, u, rule_thickness, bar, math_axis," &
    "     asc_height, eps, monospace, fudge, crisp, hair;" &
    "boolean monospace;" &

    "math_spread     :=" & decimal math_spread & ";" &
    "x_height#       :=" & decimal x_height# & ";" &
    "u#              :=" & decimal u# & ";" &
    "rule_thickness# :=" & decimal rule_thickness# & ";" &
    "bar#            :=" & decimal bar# & ";" &
    "math_axis#      :=" & decimal math_axis# & ";" &
    "asc_height#     :=" & decimal asc_height# & ";" &
    "eps             :=" & decimal eps & ";" &
    "monospace       :=" & if monospace: "true" else: "false" fi & ";" &
    "fudge           :=" & decimal fudge & ";" &
    "crisp#          :=" & decimal crisp# & ";" &
    "hair#           :=" & decimal hair# & ";")
      
    save prevpen;
    prevpen:=savepen;

    save x,y;
    numeric x[], x[]', x[]l, x[]'l, x[]r, x[]'r,
            y[], y[]', y[]l, y[]'l, y[]r, y[]'r;
    save spread, w;
    numeric spread, w;
  
    if crisp#>fudge*hair#:
      crisp#:=fudge*hair#;
    fi
    pickup if crisp#=0: nullpen else: pencircle scaled crisp# fi;

    spread = math_spread[.45x_height#, .55x_height#];
    w = 18u#;

    penpos1(rule_thickness#, 90); penpos2(rule_thickness#, 90);
    penpos3(rule_thickness#,  0); penpos4(rule_thickness#,  0);
    y0=y1=y2=math_axis#; x1-.5rule_thickness#=u#; rt x0=w-u#;
    y3-y0=y0-y4=.36asc_height#+eps;
    x3=x4=x0-4u#-eps;
    penpos5(rule_thickness#, angle(z4-z0)); z5l=z0;
    penpos6(rule_thickness#, angle(z3-z0)); z6l=z0;
    save t; numeric t; 
    save pq; path pq;    pq = z4l..{2(x0-x4),y0-y4}z6r;
    t=xpart(pq intersectiontimes ((0,y2l)--(w,y2l))); x2=xpart point t of pq;
    z9=.2[.5[z3,z4],z0];

    save mapto, n;
    vardef mapto(text t) =
      hide(numeric n; n:=0;
           numeric x,x_[],y,y_[];
           for z=t: z_[incr n]:=z; endfor;
           transform T;
           z_2 = z_1 transformed T;
           z_4 = z_3 transformed T;
           z_6 = z_5 transformed T;)
      T
    enddef;
  
    save T;   transform T;
    save tt;  numeric tt;  tt  = arctime(arclength apth - (x0-x9)) of apth;
    save ttt; numeric ttt; ttt = arctime(arclength apth - (x0-x2)) of apth;

    % Draw the arrow head

    save pp; path pp; pp := (z3l..{2(x0-x3),y0-y3}z5r);
    save pq; path pq; pq := (z3r..{2(x0-x3),y0-y3}z5l);

    save halfarrowhead, pa;
    vardef halfarrowhead(expr T, s) =
      (z0--(x0,y2l)--z2l--z2r
         ..subpath(t,s) of pp
         --subpath(xpart( pq intersectiontimes
	             (point s of pp -- point s of pp +(2rule_thickness#,0))),
	           length (z3r..{2(x0-x3),y0-y3}z5l)) of pq --cycle)
      transformed T
    enddef;
    
    if     arclength apth = 0:
      T:=identity reflectedabout(z0+(-1pt,0),z0)
                  shifted (point (length apth) of apth - z0);
    elseif arclength apth < x0-x3l:
      T:=identity reflectedabout(z0+(-1pt,0),z0)
                  rotatedaround(z0,angle (direction (length apth) of apth))
                  shifted (point (length apth) of apth -z0);
    else:
      T:=mapto(z0,
               point (length apth) of apth,
               z2,
               point ttt of apth,
               z9+(0,3rule_thickness#),
               point tt of apth - 3rule_thickness#*
                     (unitvector (direction tt of apth) rotated 90));
    fi

    save f,s;
    vardef f(expr s) =
      length(point s of (pp transformed T) - point tt of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    filldraw halfarrowhead(T,s) text_;

    % Draw the path

    if arclength apth > x0-x2: draw subpath(0,ttt) of apth
      withpen pencircle scaled rule_thickness# text_;
    fi
  
    pickup prevpen;

  enddef;

enddef;