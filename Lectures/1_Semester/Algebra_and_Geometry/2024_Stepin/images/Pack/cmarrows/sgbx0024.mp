%% sgbx0024.mp
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

vardef setup_tripplearrow (expr source_file, cmdname) =

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

    spread = math_spread[.45x_height#,.55x_height#];
    w:=18u#;

    penpos1(rule_thickness#, 90); penpos2(rule_thickness#, 90);
    penpos3(1.5bar#, 0);          penpos4(1.5bar#, 0);
    y0=y1=y2=math_axis#; x1-.5rule_thickness#=u#; rt x0 = w-u#;
    x0'=x0''=x0; x1'=x1''=x1;
    y1'=y1+spread; y1''=y1-spread; y0'=y1'; y0''=y1'';

    y3-y0'=y0''-y4=.24asc_height#+eps; x3=x4=x0-6u#-eps;
    penpos5(bar#,angle(z0-z4)); z5r=z0; penpos6(bar#,angle(z0-z3));
    z6r=z0; z9=.381966[.5[z3,z4],z0];
    save pp;
    path pp;     pp = z4l{z9-z4}..z6l;
    save ss;
    numeric ss;  ss = xpart(pp intersectiontimes ((0,y2l)--(w,y2l)));
    x2 = xpart point ss of pp;
    save t;
    numeric t;   t  = xpart(pp intersectiontimes ((0,y0'')--(w,y0'')));
    numeric t[]; t1 = xpart(pp intersectiontimes ((0,y0''-rule_thickness#/2)
	                                        --(w,y0''-rule_thickness#/2)));
                 t2 = xpart(pp intersectiontimes ((0,y0''+rule_thickness#/2)
                                                --(w,y0''+rule_thickness#/2)));
                 t3 = xpart(pp intersectiontimes ((x2,y4)--(x2,y3)));
    save qq;
    path qq;     qq = z3l{z9-z3}..z5l;

    save parallelline;
    vardef parallelline expr ppp =
      save s, stp;
      numeric s, stp; stp:=(arclength ppp) div 5pt;
                      if stp=0: stp:=1; fi
                      stp:=(arclength ppp)/stp;
  
      if stp > 0:
      draw for s=0 step stp until arclength ppp - stp:
             point (arctime s of ppp) of ppp + 
             spread*(unitvector direction (arctime s of ppp) of ppp rotated 90)
             {direction (arctime s of ppp) of ppp}..
           endfor
           {direction (length ppp) of ppp}
           point (length ppp) of ppp + 
           spread*(unitvector direction (length ppp) of ppp rotated 90)
	   withpen pencircle scaled rule_thickness#
	   text_;
  
      draw for s=0 step stp until arclength ppp - stp:
             point (arctime s of ppp) of ppp - 
             spread*(unitvector direction (arctime s of ppp) of ppp rotated 90)
             {direction (arctime s of ppp) of ppp}..
           endfor
           {direction (length ppp) of ppp}
           point (length ppp) of ppp - 
           spread*(unitvector direction (length ppp) of ppp rotated 90)
	   withpen pencircle scaled rule_thickness#
	   text_;
      fi
    enddef;
  
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
    
    % Draw the arrow head

    save tripplearrowhead;
    vardef tripplearrowhead(expr T,s,ss) =
      (subpath(0,xpart((z0..{z4-z9}z4r) intersectiontimes
	      (point s of pp -- point s of pp + (2rule_thickness#,0))))
         of (z0..{z4-z9}z4r)
       --subpath(s,t1) of pp
       --(xpart point t1 of pp, ypart point t2 of pp)
       --subpath(t2,t3) of pp
       --subpath(t3,t2) of qq
       --(xpart point t1 of qq, ypart point t2 of qq)
       --subpath(t1,ss) of qq
       --subpath(xpart((z3r{z9-z3}..z0) intersectiontimes
	        (point ss of qq -- point ss of qq + (2rule_thickness#,0))),1)
	   of (z3r{z9-z3}..z0)
	   & cycle) transformed T
    enddef;
       
    save T; transform T;
    save tt;
    tt  = arctime (arclength apth - (x0 - xpart point t1 of pp)) of apth;
    save ttt;
    ttt = arctime (arclength apth - (x0 - x2)) of apth;

    if arclength apth = 0:
      T:=identity shifted (point (length apth) of apth - z0);
    elseif arclength apth < x0-xpart(point t1 of pp):
      T:=identity rotatedaround(z0, angle (direction (length apth) of apth))
                  shifted (point (length apth) of apth - z0);
    else:
      T := mapto(z2,
                 point ttt of apth,
                 point t1 of pp + (0,rule_thickness#/2),
                 point tt of apth + 
                       spread*(unitvector direction tt of apth rotated 90),
                 point t1 of qq - (0,rule_thickness#/2),
                 point tt of apth - 
                       spread*(unitvector direction tt of apth rotated 90));
    fi
    
    save f,s,ss;
    ttt := arctime(arclength apth - (x0-x9)) of apth;
    vardef f(expr s) =
      length(point s of (pp transformed T) - point ttt of apth)
      < length(point 0 of pp - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): s := 0;
    else:    s := solve f(length pp, 0);
    fi

    vardef f(expr ss) =
      length(point ss of (qq transformed T) - point ttt of apth)
      < length(point 0 of qq - z9)
    enddef;

    if f(0) or (arclength apth < x0-x3l): ss := 0;
    else:    ss := solve f(length qq, 0);
    fi

    filldraw tripplearrowhead(T,s,ss) text_;
    
    % Draw the path
    
    ttt := arctime (arclength apth - (x0 - x2)) of apth;
    if arclength apth > x0 - xpart(point t1 of pp):
      parallelline (subpath(0,tt) of apth);
    fi

    if arclength apth > x0 - x2:
      draw subpath(0,ttt) of apth withpen pencircle scaled rule_thickness#
      text_;
    fi

    pickup prevpen;

  enddef;

enddef;




