(function(){var v={Version:"7.5.5900.27885"},a,w;"undefined"!==typeof window?(a=window.sfx,w=window.cfx):(a=require("./jchartfx.system.js"),w=a.cfx,module.exports=v);w.annotation=v;v.AnnImageMode={Original:0,Stretch:1,Tile:2,StretchRatio:3};v.AttachMode={None:0,Point:1,Elastic:2};v.BalloonTailCorner={TopLeft:0,TopRight:1,BottomRight:2,BottomLeft:3,Top:4,Right:5,Bottom:6,Left:7};var x=function(){};x.d=function(a){return 0==a.w||0==a.h};x.b=function(a,k,C){k.c()||C.c()||(a.x=~~(a.x*k.x/C.x),a.w=~~(a.w*
k.x/C.x),a.y=~~(a.y*k.y/C.y),a.h=~~(a.h*k.y/C.y))};x.c=function(k,m,C,c){var h=0,g=0,f=0,b=0;k&&(h=c.x,g=c.y,f=c.w,b=c.h);var e=new a._p1(h);m.ieY(e,C+"Left",0);h=e.a;e.a=g;m.ieY(e,C+"Top",0);g=e.a;e.a=f;m.ieY(e,C+"Width",0);f=e.a;e.a=b;m.ieY(e,C+"Height",0);b=e.a;k||(c.x=h,c.y=g,c.w=f,c.h=b)};x.a=function(a,k,m){a.m(a.x<=a.g()?k:-k,a.y<=a.c()?m:-m)};var E=function U(){U._ic();this.a=null};v.SerializableArrowCap=E;E.prototype={_0_1:function(){return this},_01_1:function(a){this.a=a;return this},ieJ:function(k,
m){null==this.a&&(this.a=(new a.av)._0av(5,5,!0));var c=this.a.h,h=new a._p1(c);m.ieZ(h,"Height",5);c=h.a;this.a.h=c;c=this.a.w;h.a=c;m.ieZ(h,"Width",5);c=h.a;this.a.w=c}};E._dt("CWAS",a.SA,0,w.ieI);var H=function C(){C._ic();this.b=this.c=this.a=null};v.AnnotationTooltip=H;H.prototype={_0_1:function(){return this},getData:function(){return this.a},setData:function(a){this.a=a},getTemplate:function(){return this.c},setTemplate:function(a){this.c=a},getTitle:function(){return this.b},setTitle:function(a){this.b=
a}};H._dt("CWAA",a.SA,0);var m=function c(){c._ic();this.p=this.A=null;this.n=this.o=0;this.G=this.H=this.c=this.f=this.h=null;this.E=this.F=!1;this.i=null};m.prototype={_0dO:function(){this.m=new a.m;this.a=new a.c;this.g=new a.c;this.Y=new a.c;this.y=new a.c;this.I=!0;this.d=null;this.m._cf(a.m.g());this.b=(new w.Line)._01_2(3);this.b.setColor(a.m.c());this.e=0;this.x=!0;this.z=-1;this.u=5;this.q=this.l=1;return this},getAnchor:function(){return this.u},setAnchor:function(c){this.u=c;this.detach()},
getAttachAxisY:function(){return this.p},setAttachAxisY:function(c){this.p=c},bA:function(){return this.e},getAttachUnitX:function(){return this.o},setAttachUnitX:function(c){this.o=c},getAttachUnitY:function(){return this.n},setAttachUnitY:function(c){this.n=c},getBorder:function(){return this.b},setBorder:function(c){this.b=c},K:function(){return this.g._nc()},getColor:function(){return this.m},setColor:function(c){c=a.m._t(c);this.m._cf(c)},id0:function(){return null},getHeight:function(){return this.g.h},
setHeight:function(c){this.C(0,c-this.g.h,!0,576,!1)},id1:function(){return 14},getInteractive:function(){return this.I},setInteractive:function(c){this.I=c},getLeft:function(){return this.g.x},setLeft:function(c){this.D(c-this.g.x,0,!0,!1)},getObjectBounds:function(){return this.a},setObjectBounds:function(c){this.a._cf(c);this.B()},W:function(){return""},getPaintBefore:function(){return this.F},setPaintBefore:function(c){this.F=c},getPattern:function(){return this.z},setPattern:function(c){this.z=
c},getPlotAreaOnly:function(){return this.E},setPlotAreaOnly:function(c){this.E=c},U:function(){return(new a.g)._01g(this.g.g()-this.g.x,this.g.c()-this.g.y)},getTag:function(){return this.G},setTag:function(c){this.G=c},getToolTip:function(){null==this.i&&(this.i=(new H)._0_1());return this.i},getTop:function(){return this.g.y},setTop:function(c){this.D(0,c-this.g.y,!0,!1)},getVisible:function(){return this.x},setVisible:function(c){this.x=c},getWidth:function(){return this.g.w},setWidth:function(c){this.C(c-
this.g.w,0,!0,2112,!1)},attach:function(c,a){this.q=this.l=1;this.L(1,[c,a])},L:function(c,a){var g=!1,g=!1;0!=c?null==a&&(1==c?a=[0,0]:2==c&&(a=[0,0,0,0]),g=!0):a=null;this.d=a;this.e=c;this.j(g)},attachElastic:function(c,a,g,f){this.L(2,[c,a,g,f])},attachAlign:function(c,a,g,f){this.q=c;this.l=g;this.L(1,[a,f])},B:function(){this.j(!0)},j:function(c){c&&0!=this.e&&null!=this.h&&this.V();this.y._cf(this.a);this.g._cf(this.k(this.a._nc()))},ae:function(){return-1==this.z?this.m.e()?null:(new a.ar)._0ar(this.m):
(new a.aB)._0aB(this.z,this.b.getColor(),this.m)},ad:function(){if(a.m.o(this.b.getColor(),a.m.g()))return null;var c=this.b.c(a.m.b._nc());c.sb(1);return c},detach:function(){this.L(0,null)},flip:function(c){this.T(c,-1)},T:function(c,h){var g=this.a._nc();c?-1==h?this.a._cf(a.c.l(g.x,g.c(),g.g(),g.y)):this.a._cf(a.c.l(g.x,h-g.c(),g.g(),h-g.y)):-1==h?this.a._cf(a.c.l(g.g(),g.y,g.x,g.c())):this.a._cf(a.c.l(h-g.g(),g.y,h-g.x,g.c()));this.B()},J:function(c){var a=null,a=c?this.W():this.X();if(null==
a)return null;a="Annotation"+a+" AnnotationObj"+this.H;if(null!=this.G){var g=this.G.toString();c&&(g+="Text");a=g+" "+a}return a},ifj:function(c){if(!this.I)return null;var a=null!=this.i;switch(c){case 1:return(a?"A,":"-A,")+this.H;case 2:return this.J(!1);case 0:if(a)return"A";break;case 4:if(a)return this.i.b}return null},ifm:function(a){if(null!=this.i){var h=this.i.a;if(null!=h)return h[a]}return null},ifk:function(c){switch(c){case 7:if(null!=this.i)return c=this.i.c,a.b.p(c)&&(c=null,c=null==
this.i.a?"Set Template or Data":this.i.a.toString(),c='<DataTemplate><TextBlock Text="'+c+'"/></DataTemplate>'),(new w.cD)._0cD(c)}return null},aa:function(){var c=new a.c;null!=this.h&&(c._cf(this.K()),c.m(this.b.d,this.b.d),this.h.iaF(c._nc()))},Z:function(c){var h=0,g=0,f=0,b=0;c=c._nc();switch(this.e){case 1:f=new a._pN(h,g,this.d[0],this.d[1]);b=this.h.iaH(f,1,this.o,this.n,this.p);h=f.a;g=f.b;this.d[0]=f.c;this.d[1]=f.d;if(!b)break;switch(this.q){case 0:c.x=h;break;case 2:c.x=h-c.w;break;case 1:c.x=
h-~~(c.w/2)}switch(this.l){case 0:c.y=g;break;case 2:c.y=g-c.h;break;case 1:c.y=g-~~(c.h/2)}break;case 2:var e=new a._pN(h,g,this.d[0],this.d[1]),d=this.h.iaH(e,1,this.o,this.n,this.p),h=e.a,g=e.b;this.d[0]=e.c;this.d[1]=e.d;if(!d)break;e=new a._pN(f,b,this.d[2],this.d[3]);d=this.h.iaH(e,1,this.o,this.n,this.p);f=e.a;b=e.b;this.d[2]=e.c;this.d[3]=e.d;if(!d)break;c.x=h;c.y=g;c.w=f-h;c.h=b-g}return c},D:function(a,h,g,f){this.a._cf(this.y);this.a.q(a,h);g&&this.j(f)},k:function(a){if(0>a.w){var h=a.w;
a.w=-h;a.x+=h}0>a.h&&(h=a.h,a.h=-h,a.y+=h);return a},O:function(a,h){this.D(a,h,!0,!1)},Q:function(a){if(this.x){var h=a.idc();this.H=this.A.g();a.sidc(this);this.f=this.ae();this.c=this.ad();this.ab(a,!1,this.y._nc());null!=this.f&&(this.f._d(),this.f=null);null!=this.c&&(this.c._d(),this.c=null);a.sidc(h)}},V:function(){var c=0,h=0;switch(this.e){case 1:switch(this.q){case 0:c=this.a.x;break;case 2:c=this.a.g();break;case 1:c=~~((this.a.x+this.a.g())/2)}switch(this.l){case 0:h=this.a.y;break;case 2:h=
this.a.c();break;case 1:h=~~((this.a.y+this.a.c())/2)}c=new a._pN(c,h,this.d[0],this.d[1]);h=this.h.iaH(c,0,this.o,this.n,this.p);this.d[0]=c.c;this.d[1]=c.d;h||(this.e=0);break;case 2:c=this.a.x;h=this.a.y;c=new a._pN(c,h,this.d[0],this.d[1]);h=this.h.iaH(c,0,this.o,this.n,this.p);this.d[0]=c.c;this.d[1]=c.d;if(!h){this.e=0;break}c=this.a.g();h=this.a.c();c=new a._pN(c,h,this.d[2],this.d[3]);h=this.h.iaH(c,0,this.o,this.n,this.p);this.d[2]=c.c;this.d[3]=c.d;h||(this.e=0)}},refresh:function(){0!=
this.e&&this.t((new a.e)._01e(0,0),(new a.e)._01e(0,0));this.aa()},t:function(a,h){this.Y._cf(this.a);if(!this.a.SB(this.y))return!1;0!=this.e&&(this.a._cf(this.Z(this.a)),this.j(!1));return!1},C:function(a,h,g,f,b){this.a._cf(this.y);320==(f&320)&&(this.a.y+=h,this.a.h-=h);576==(f&576)&&(this.a.h+=h);1088==(f&1088)&&(this.a.x+=a,this.a.w-=a);2112==(f&2112)&&(this.a.w+=a);g&&this.j(b)},rotate:function(c){this.N(c,(new a.e)._01e(0,0))},N:function(c,h){h.c()&&(h.x=~~((this.a.x+this.a.g()+1)/2),h.y=
~~((this.a.y+this.a.c()+1)/2));this.a.q(-h.x,-h.y);c?this.a._cf(a.c.l(-this.a.y,this.a.x,-this.a.c(),this.a.g())):this.a._cf(a.c.l(this.a.y,-this.a.x,this.a.c(),-this.a.g()));this.a.q(h.x,h.y);this.B()},ieJ:function(a,h){this.w(a,h)},w:function(c,h){x.c(c,h,a.b.b,this.a);this.e=h.ie2("Attached",this.e,0);0!=this.e?(c||(this.d=[]),this.d=h.ie3("LogicalPosition",this.d,null,32)):this.d=null;h.ieT("BackColor",this.m);this.b=h.ie3("Border",this.b,"Line",0);var g=new a._p1(this.x);h.ie1(g,"Visible",!0);
this.x=g.a;g.a=this.F;h.ie1(g,"PaintBefore",!1);this.F=g.a;g.a=this.E;h.ie1(g,"PlotAreaOnly",!1);this.E=g.a;this.u=h.ie2("Anchor",this.u,5);this.q=h.ie2("AttachHorizontal",this.q,1);this.l=h.ie2("AttachVertical",this.l,1);c||this.B()},M:function(a){this.A=a;this.h=null!=a?a.c:null}};m._dt("CWAA",a.SA,0,w.ieI,w.ifi,w.ifl,a.Su);var k=function h(){h._ic();this._0_3()};v.AnnotationVector=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);this.aq=(new w._Zt)._0_Zt();return this},X:function(){return"Vector"},
getTemplate:function(){return this.aq.u()},setTemplate:function(a){this.aq.su(a)},ab:function(h,g,f){if(!a.b.p(this.aq.u())){g=a.d.r(f);f=this.aq.id().L.A;for(var b=f.length,e=0;e<b;e++){var d=f[e];switch(d.bA()){case "F":case "Fill":d.sb(this.f);break;case "S":case "Stroke":d.sb(this.c);break;case "W":case "Width":d.sb(g.w);break;case "H":case "Height":d.sb(g.h);break;case "FC":case "FillColor":d.sb(this.m);break;case "ST":case "StrokeThickness":d.sb(this.b.d);break;case "SD":case "StrokeDashStyle":d.sb(this.b.e)}}f=
this.aq.C(h,(new a.l)._01g(0,0));g.h<f.h&&(g.h=f.h);this.aq.v(h,g,1,8)}},t:function(h,g){if(null!=this.aq&&(0==this.a.w||0==this.a.h)){var f=this.aq.C(this.A.f(),a.l.b);0==this.a.w&&(this.a.w=f.w);0==this.a.h&&(this.a.h=f.h);this.j(!1)}return m.prototype.t.call(this,h._nc(),g._nc())}};k._dt("CWAA",m,0);var A=function g(){g._ic();this.ar=0;this.at=null;this.aH=0;this.aC=!1;this._0_3()};v.AnnotationText=A;A.prototype={_0_3:function(){this._bc._0dO.call(this);this.aw=new a.m;this.as=1024;this.ay=this.az=
this.av=0;this.au="Text";this.aw._cf(a.m.c());this.ax=!1;return this},getAlign:function(){return this.az},setAlign:function(a){this.az=a},getClip:function(){return 0==(this.as&512)},setClip:function(a){this.as=a?this.as&-513:this.as|512},getCornerRadius:function(){return this.ar},setCornerRadius:function(a){this.ar=a},getFont:function(){return this.at},setFont:function(g){this.at=g=a.o._t(g);this.sizeToFit()},getLineAlignment:function(){return this.ay},setLineAlignment:function(a){this.ay=a},aB:function(){return null!=
this.at?this.at:null!=this.h?this.h.iaB():null},X:function(){return"TextBorder"},W:function(){return"Text"},getOrientation:function(){return this.av},setOrientation:function(a){this.av=a},getResizeableFont:function(){return this.aC},setResizeableFont:function(a){this.aC=a},getText:function(){return this.au},setText:function(a){this.au=a;this.sizeToFit()},getTextColor:function(){return this.aw},setTextColor:function(g){g=a.m._t(g);this.aw._cf(g)},aG:function(){var a=this.g._nc();a.m(-this.b.d,-this.b.d);
x.a(a,-(this.ar-1),-(this.ar-1));return a},getWordWrap:function(){return 0!=(this.as&1024)},setWordWrap:function(a){this.as=a?this.as|1024:this.as&-1025},aJ:function(g,f,b,e){var d=0==f||2==f,q=0;d?(q=~~((b.x+b.g())/2),e=a.a.p(e,~~(b.w/2)-e)):(q=~~((b.y+b.c())/2),e=a.a.p(e,~~(b.h/2)-e));var n=q-e,l=q+e;if(d){var r=d=0;0==f?(d=b.y,r=d-e):(d=b.c(),r=d+e,f=n,n=l,l=f);g.t(n,d,q,r);g.t(q,r,l,d)}else r=d=0,1==f?(d=b.g(),r=d+e):(d=b.x,r=d-e,f=n,n=l,l=f),g.t(d,n,r,q),g.t(r,q,d,l)},aF:function(a,f,b,e,d,q,
n){d*=2;d=[(new F)._01dP(f.x,f.y,d,d,180,90),(new F)._01dP(f.g()-d,f.y,d,d,270,90),(new F)._01dP(f.g()-d,f.c()-d,d,d,0,90),(new F)._01dP(f.x,f.c()-d,d,d,90,90)];for(var l=0;l<b;l++)e=(e+1)%4,d[e].e(a),e==q&&this.aJ(a,q,f,n)},aI:function(g,f,b){var e=20,d=0,q=0;null==f&&(b=null,b=null==this.at?this.aB():this.at,f=b.f(),b=b.i());for(var n=a.a.d(this.a.w),l=a.a.d(this.a.h);;){var r=(new a.o)._02o(f,e,b),t=g.idT(this.au,r);t.w/=1.1;t.h/=1.1;r._d();if(t.w<=n&&t.h<=l){d=e;if(0!=q)break;e*=2}else{q=0==q?
e:a.a.p(q,e);if(0!=d)break;e/=2}}for(var e=.03*a.a.p(n,l),u=null,p=(new a.l)._01g(0,0),k=0;20>k;k++){var P=(d+q)/2,r=(new a.o)._02o(f,P,b),t=g.idT(this.au,r);t.w/=1.1;t.h/=1.1;var m=t.h;if(t.w<=n&&m<=l){if(m=a.a.p(n-t.w,l-t.h),null!=u&&u._d(),d=P,p._cf(t),u=r,m<=e)break}else q=P,r._d()}null!=this.at&&this.at._d();this.at=u},j:function(a){m.prototype.j.call(this,a)},aE:function(g){var f=this.aG()._nc(),b=(new a.e)._01e(~~((f.x+f.g()+1)/2),~~((f.y+f.c()+1)/2));f.q(-b.x,-b.y);for(var e=0;e<this.av;e++)f._cf(a.c.l(-f.y,
f.x,-f.c(),f.g()));f.q(b.x,b.y);f._cf(this.k(f._nc()));b=(new w.cJ)._04cJ(this.aw._nc(),this.az,this.ay,this.as,900*this.av,!0);b.i(g,this.aB(),this.au,f);b._d()},ab:function(g,f,b){f=this.k(b);0==this.ar?(null!=this.f&&g.idQ(this.f,f.x,f.y,f.w,f.h),null!=this.c&&g.idA(this.c,f.x,f.y,f.w,f.h)):(b=(new a.aA)._0aA(),this.aF(b,f,4,0,this.ar,-1,0),b.E(),null!=this.f&&g.idK(this.f,b),null!=this.c&&g.idr(this.c,b),b._d());f=this.J(!0);b=0!=(g.ic_()&8);var e;b&&(e=g.idd());if(this.aC){var d=null,q=this.aw._nc();
b&&(q=e._Gv("fill",q,f,4),d=e._Gv("font-family",d,f,1),this.aw._cf(q));g.sidc(null);this.aI(g,d,0)}else g.sidc((new w.c5)._01c5(f));this.aE(g)},t:function(a,f){this.aH=this.ar;this.ax&&this.aD(this.A.f());var b=m.prototype.t.call(this,a._nc(),f._nc());b&&(this.ar=~~(this.ar*a.y/f.y));return b},C:function(a,f,b,e,d){m.prototype.C.call(this,a,f,b,e,d);this.ax=!1},N:function(a,f){this.av=(this.av+(a?3:1))%4;m.prototype.N.call(this,a,f._nc())},w:function(g,f){m.prototype.w.call(this,g,f);var b=new a._p1(this.av);
f.ieY(b,"Orientation",0);this.av=b.a;this.as=f.ie2("TextStyle",this.as,1024);b.a=this.au;f.ieS(b,"Text");this.au=b.a;f.ieT("TextColor",this.aw);b.a=this.at;f.ieU(b,"Font");this.at=b.a;this.az=f.ie2("Align",this.az,0);this.ay=f.ie2("LineAlignment",this.ay,0)},M:function(a){m.prototype.M.call(this,a);this.ax&&this.sizeToFit()},sizeToFit:function(){this.ax=!0},aD:function(a){this.H=this.A.g();a.sidc((new w.c5)._01c5(this.J(!0)));a=a.idT(this.au,this.aB()).e();if(1==(this.av&1)){var f=a.w;a.w=a.h;a.h=
f}f=this.a._nc();f.w=a.w+2*this.b.d+1;f.h=a.h+2*this.b.d+1;x.a(f,this.ar,this.ar);this.a._cf(f);this.ax=!1;this.j(!1)}};A._dt("CWAA",m,0);var F=function f(){f._ic();this.a=new a.c;this.c=this.d=0};F.prototype={_i1:function(a,b,e,d,q,n){this.a._i2(a,b,e,d);this.d=q;this.c=n},_01dP:function(a,b,e,d,q,n){this._i1(a,b,e,d,q,n);return this},e:function(a){0==this.a.w||0==this.a.h?a.q(this.a.f(),this.a.f()):a.e(this.a,this.d,this.c)}};F._dt("CWAA",a.W,0);k=function b(){b._ic();this.aZ=0;this._0_4()};v.AnnotationBalloon=
k;k.prototype={_0_4:function(){this._bc._0_3.call(this);this.aS=new a.c;this.aY=new a.c;this.aV=12;this.ar=5;this.aT=0;this.aS.x=0;this.aR=this.aS.y=0;this.aU();return this},K:function(){return A.prototype.K.call(this)},X:function(){return"Balloon"},W:function(){return"BalloonText"},getTailCorner:function(){return this.aR},setTailCorner:function(a){this.aR=a},getTailFactor:function(){return this.aV},setTailFactor:function(a){this.aV=a},aG:function(){var b=this.a._nc();x.a(b,-this.b.d,-this.b.d);x.a(b,
-this.aT,-this.aT);b._cf(this.k(b._nc()));var e,d;d=new a._p2(0,0);this.aW(d,b);e=d.a;d=d.b;b.w-=e;b.h-=d;switch(this.aR){case 0:b.x+=e;b.y+=d;break;case 1:b.y+=d;break;case 3:b.x+=e}x.a(b,-(this.ar-1),-(this.ar-1));return b},a1:function(a){var e=this.aV;0>e?(a.w+=-e,a.h+=-e):(e/=100,a.w/=1-e,a.h/=1-e)},a0:function(b){var e=this.ar*(0>b.w?-1:1),d=this.ar*(0>b.h?-1:1),q,n;n=new a._p2(0,0);this.aW(n,b);q=n.a;n=n.b;var l=a.e._ca(3);switch(this.aR){case 0:l[1].x=b.x;l[1].y=b.y;b.x+=q;b.w-=q;b.y+=n;b.h-=
n;l[0].x=b.x;l[0].y=b.y+d;l[2].x=b.x+e;l[2].y=b.y;break;case 1:l[1].x=b.g();l[1].y=b.y;b.w-=q;b.y+=n;b.h-=n;l[2].x=b.g();l[2].y=b.y+d;l[0].x=b.g()-e;l[0].y=b.y;break;case 3:l[1].x=b.x;l[1].y=b.c();b.x+=q;b.w-=q;b.h-=n;l[2].x=b.x;l[2].y=b.c()-d;l[0].x=b.x+e;l[0].y=b.c();break;default:l[1].x=b.g(),l[1].y=b.c(),b.w-=q,b.h-=n,l[0].x=b.g(),l[0].y=b.c()-d,l[2].x=b.g()-e,l[2].y=b.c()}return l},aW:function(a,e){var d=this.aV;0>d?(a.b=-d,a.a=a.b):(d/=100,a.a=e.w*d,a.b=e.h*d)},j:function(a){A.prototype.j.call(this,
a);this.aU()},T:function(a,e){A.prototype.T.call(this,a,e);switch(this.aR){case 0:this.aR=a?3:1;break;case 1:this.aR=a?2:0;break;case 2:this.aR=a?1:3;break;case 3:this.aR=a?0:2;break;case 4:a||(this.aR=6);break;case 6:a||(this.aR=4);break;case 7:a&&(this.aR=5);break;case 5:a&&(this.aR=7)}this.aU()},ab:function(a,e,d){x.a(d,-this.aT,-this.aT);d._cf(this.k(d._nc()));this.aX(a,this.f,this.c,d._nc());a.sidc((new w.c5)._01c5(this.J(!0)));null!=this.au&&this.aE(a)},D:function(a,e,d,q){A.prototype.D.call(this,
a,e,d,q);d||this.aU()},O:function(a,e){A.prototype.O.call(this,a,e);this.aS.q(a,e)},aX:function(b,e,d,q){var n=(new a.aA)._0aA();n.H();var l=4,r=0,t=-1;4<=this.aR&&(t=this.aR-4);var u=0;if(-1==t){l=this.a0(q);for(r=1;r<l.length;r++)n.q(l[r-1],l[r]);l=3;r=this.aR}else{var r=4,p;p=new a._p2(0,0);this.aW(p,q);u=p.a;p=p.b;u=~~(a.a.o(u,p)/2)}this.aF(n,q,l,r,this.ar,t,u);n.E();null!=e&&b.idK(e,n);null!=d&&b.idr(d,n);n._d()},t:function(a,e){this.aZ=this.aT;this.aY._cf(this.aS);if(A.prototype.t.call(this,
a._nc(),e._nc())){this.aT=~~(this.aT*a.y/e.y);var d=~~(this.aS.x*a.x/e.x),q=d-this.aS.x;this.aS.x=d;this.aS.w-=q;d=~~(this.aS.y*a.y/e.y);q=d-this.aS.y;this.aS.y=d;this.aS.h-=q;return!0}return!1},C:function(a,e,d,q,n){A.prototype.C.call(this,a,e,d,q,n);d?this.aR=0>this.a.w?0>this.a.h?2:1:0>this.a.h?3:0:this.aU()},N:function(a,e){A.prototype.N.call(this,a,e._nc());var d=0;4<=this.aR&&(d=4,this.aR-=4);this.aR=a?(this.aR+1)%4:(this.aR+4-1)%4;this.aR+=d},w:function(b,e){var d=0,q=0;A.prototype.w.call(this,
b,e);var n=new a._p1(this.aV);e.ieY(n,"TailFactor",12);this.aV=n.a;n.a=this.ar;e.ieY(n,"CornerRadius",5);this.ar=n.a;n.a=this.aT;e.ieY(n,"Shadow",3);this.aT=n.a;this.aR=e.ie2("TailCorner",this.aR,0);b&&(d=this.aS.x,q=this.aS.y);n.a=d;e.ieY(n,"ArrowX",0);d=n.a;n.a=q;e.ieY(n,"ArrowY",0);q=n.a;b||(this.aS.x=d,this.aS.y=q,this.aU())},aD:function(a){A.prototype.aD.call(this,a);a=this.a._nc();x.a(a,this.aT,this.aT);this.a1(a);this.a._cf(a);this.j(!1)},aU:function(){}};k._dt("CWAA",A,0);k=function e(){e._ic();
this._0_3()};v.AnnotationRectangle=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);return this},X:function(){return"Rectangle"},ab:function(a,d,q){d=this.k(q);null!=this.f&&a.idQ(this.f,d.x,d.y,d.w,d.h);null!=this.c&&a.idA(this.c,d.x,d.y,d.w,d.h)}};k._dt("CWAA",m,0);k=function d(){d._ic();this.as=this.at=0;this.av=!1;this.aq=null;this._0_3()};v.AnnotationPicture=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);this.ar=0;this.au=1;return this},getGrayscale:function(){return this.av},
setGrayscale:function(a){this.av=a},getMode:function(){return this.ar},setMode:function(a){this.ar=a},X:function(){return null},getOpacity:function(){return this.au},setOpacity:function(a){this.au=a},getPicture:function(){return null!=this.aq?this.aq:null},setPicture:function(d){d=a.an._t(d);this.ax();this.aq=d;null!=d&&(this.at=this.aq.c(),this.as=this.aq.b());this.sizeToFit()},ax:function(){null!=this.aq&&(this.aq._d(),this.aq=null)},ab:function(d,q,n){var l=this.k(n);null!=this.f&&d.idQ(this.f,
l.x,l.y,l.w,l.h);null!=this.c&&d.idA(this.c,l.x,l.y,l.w,l.h);if(null!=this.aq){var r=0,t=0,u=0,p=0,k=0,m=0;q=!1;var w=0,x=0,u=d.idd(),y=0,v=0,y=this.U();0!=this.b.getColor().a&&(r=2*this.b.d-1,y.w-=r,y.h-=r);r=l.x+this.b.d;t=l.y+this.b.d;l=null;if(1!=this.au||this.av)l=new a.aH,p=new a.aG,p.m33=this.au,this.av&&(p.m00=.333,p.m01=.333,p.m02=.333,p.m10=.333,p.m11=.333,p.m12=.333,p.m20=.333,p.m21=.333,p.m22=.333),l.b(p);switch(this.ar){case 1:u=y.w;p=y.h;k=this.at;m=this.as;break;case 3:var v=this.at/
this.as,B=y.w/y.h,u=y.w,p=y.h,k=this.at,m=this.as;v<B?(u=y.h*v,r+=~~((y.w-u)/2)):(p=y.w/v,t+=~~((y.h-p)/2));break;default:2==this.ar&&(q=!0),w=3.937007874016E-4*u.c(),x=3.937007874016E-4*u.d(),u=this.at,p=this.as,u=a.a.p(u,y.w),p=a.a.p(p,y.h),k=u/w,m=p/x}B=n.x>n.g();n=n.y>n.c();do if(y=(v=1==this.ar||3==this.ar)?k:u,v=v?m:p,d.idn(this.aq,(new a.c)._02c(r,t,u,p),B?this.at:0,n?this.as:0,B?-y:y,n?-v:v,2,l),q){r+=u;m=this.g._nc();if(r>=m.g()&&(r=m.x,t+=p,t>=m.c()))break;u=this.at;u=a.a.p(u,m.g()-r);k=
u/w;p=this.as;p=a.a.p(p,m.c()-t);m=p/x}while(q)}},w:function(d,q){m.prototype.w.call(this,d,q);this.ar=q.ie2("Mode",this.ar,0);var n=new a._p1(this.aq);q.ieV(n,"Picture");this.aq=n.a;d||null==this.aq||(this.at=this.aq.c(),this.as=this.aq.b())},sizeToFit:function(){var a=this.a._nc();a.w=this.at+2*this.b.d;a.h=this.as+2*this.b.d;this.a._cf(a);this.B()}};k._dt("CWAA",m,0);k=function q(){q._ic();this.aq=null;this._0_3()};v.AnnotationContainer=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);this.ar=
!0;return this},getElement:function(){return this.aq},setElement:function(q){this.aq=a.V.C(q,w.iez)},X:function(){return"Container"},ab:function(a,n,l){if(null!=this.aq){n=null;var r=this.aq.ieA();null==r&&(r="jchartfx");var t=a.idd(),u=t.CN;n=t._AN(1,null);n.setAttribute("class",r);this.h.iaz(this.aq,n);this.aq.ieC(this.h,a,l._nc());t.CN=u}},t:function(a,n){if(this.ar){var l=this.aq.ieB(this.h);0!=l.w&&0!=l.h&&(this.a.w=l.w,this.a.h=l.h);this.ar=!1;this.j(!1)}return m.prototype.t.call(this,a._nc(),
n._nc())}};k._dt("CWAA",m,0);k=function n(){n._ic();this._0_3()};v.AnnotationCircle=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);return this},X:function(){return"Circle"},ab:function(a,l,r){l=this.k(r);null!=this.f&&a.idI(this.f,l.x,l.y,l.w,l.h);null!=this.c&&a.idj(this.c,l.x,l.y,l.w,l.h)}};k._dt("CWAA",m,0);k=function l(){l._ic();this._0_3()};v.AnnotationArrow=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);this.aq=null;this.ar=(new E)._01_1((new a.av)._0av(5,5,!0));return this},
K:function(){var a=m.prototype.K.call(this)._nc();if(null!=this.aq){var r=this.aq.a;a.m(r.w,r.h)}null!=this.ar&&(r=this.ar.a,a.m(r.w,r.h));return a},getEndCap:function(){return null==this.ar?null:this.ar.a},setEndCap:function(a){this.ar=null!=a?(new E)._01_1(a):null},X:function(){return"Arrow"},getStartCap:function(){return null==this.aq?null:this.aq.a},setStartCap:function(a){this.aq=null!=a?(new E)._01_1(a):null},ab:function(a,r,t){null!=this.c&&(null!=this.aq&&this.c.sf(this.aq.a),null!=this.ar&&
this.c.se(this.ar.a),a.idp(this.c,t.x,t.y,t.g(),t.c()))},w:function(a,r){m.prototype.w.call(this,a,r);this.aq=r.ie3("StartCap",this.aq,null,64);this.ar=r.ie3("EndCap",this.ar,null,64)}};k._dt("CWAA",m,0);k=function r(){r._ic();this._0_3()};v.AnnotationArc=k;k.prototype={_0_3:function(){this._bc._0dO.call(this);return this},X:function(){return"Arc"},ab:function(r,t,u){t=90;if(!x.d(u)){var p=this.k(u._nc())._nc(),k=p.w,m=p.h;p.w=2*k;p.h=2*m;0>u.w?(p.x-=k,0>u.h?t=270:(p.y-=m,t=0)):0>u.h?t=180:p.y-=m;
a.m.p(this.m,a.m.g())&&r.idL(this.f,p,t,90);null!=this.c&&r.idg(this.c,p.x,p.y,p.w,p.h,t,90)}}};k._dt("CWAA",m,0);var G=function t(){t._ic();this.c=!1};G.prototype={_0dQ:function(a){this._bc._0Y.call(this);this.a=a;return this},b:function(){return this.a},sb:function(a){this.a=a},getItem:function(a){return this._Sa().So(a)},add:function(a){this._Sa().Si(a)},clear:function(){this._Sa().clear()},contains:function(a){return this._Sa().Sj(a)},copyTo:function(a,u){this._Sa().Sd(a,u)},indexOf:function(a){return this._Sa().Sk(a)},
insert:function(a,u){this._Sa().Sl(a,u)},_Sb:function(){a.Y.prototype._Sb.call(this);this.c=!0;this.a.d()},_Sc:function(k,u){a.Y.prototype._Sc.call(this,k,u);var p=a.V.D(u,m);null!=p&&p.M(this.a);this.c=!0;this.a.d()},_Sd:function(k,u){a.Y.prototype._Sd.call(this,k,u);this.c=!0;this.a.d()},remove:function(a){this._Sa().Sm(a)},getCount:function(){return this.Se()},removeAt:function(a){this.Sn(a)}};G._dt("CWAA",a.Y,0,a.Su);var M=function u(){u._ic();this.D=null;this.B=this.C=!1;this.q=0;this.y=null;
this.x=0;this.w=null};v.AnnotationList=M;M.prototype={_0_3:function(){this._01_3(null);return this},_01_3:function(k){this._bc._0dQ.call(this,k);this.A=new a.m;this.z=new a.m;this.p=new a.c;this.o=new a.c;this.r=new a.c;this.A._cf(a.m.g());this.z._cf(a.m.c());this.y=this.D=null;this.C=!1;this.w=null;this.p._cf(a.c.b);this.x=1;this.B=!1;return this},b:function(){return G.prototype.b.call(this)},sb:function(a){G.prototype.sb.call(this,a)},E:function(){return null!=this.b()?this.b().c:null},_Sb:function(){G.prototype._Sb.call(this)},
t:function(k,p,m,v,w,Q){w=new a.c;Q=new a.c;var y=new a.c,A=new a.c,B=new a.c,I=new a.c,E=new a.c,D=new a.c,F=new a.c,G=new a.c,J=0,O=0,K=0,H=0,K=J=k.idd().c(),H=O=k.idd().d(),J=(new a.e)._01e(J,O),K=(new a.e)._01e(K,H);this.p._cf(a.c.b);H=p.d();y._cf(this.E().iaw());var O=k.ida(),M=(new a.aq)._0aq(y),V=!this.o.d()&&!p.SB(this.o),W=!this.o.d()&&!y.SB(this.o);I._cf(p);E._cf(y);F._cf(this.o);G._cf(this.r);x.b(I,K,J);x.b(E,K,J);x.b(F,K,J);x.b(G,K,J);this.q=-1;var R=0!=(m&4);m=R!=(0!=(m&2));for(var T=
this.L.A,X=T.length,S=0;S<X;S++){var z=T[S];this.q++;if(z.F==v){if(m){var L=!0;0==z.e?L=!1:0!=z.o&&0!=z.n&&(L=!1);if(L){if(!R)continue}else if(R)continue}(L=z.E)?(A._cf(y),D._cf(E),D.q(-I.x,-I.y),B._cf(G)):(A._cf(p),D._cf(I),B._cf(F));var Y=L?W:V;if(0==z.e){var N=z.u;Y&&(0==N?(z.setTop(z.getTop()+~~((D.h-B.h)/2)),z.setLeft(z.getLeft()+~~((D.w-B.w)/2))):(0!=(N&8)&&(0!=(N&4)?z.setWidth(z.getWidth()+(D.w-B.w)):z.setLeft(z.getLeft()+(D.w-B.w))),0!=(N&2)&&(0!=(N&1)?z.setHeight(z.getHeight()+(D.h-B.h)):
z.setTop(z.getTop()+(D.h-B.h))),L&&(0!=(N&4)&&z.setLeft(z.getLeft()+(D.x-B.x)),0!=(N&1)&&z.setTop(z.getTop()+(D.y-B.y)))));z.O(I.x,I.y)}z.t(J._nc(),K._nc());H?z.Q(k):(w._cf(z.K()),this.p._cf(a.c.t(this.p,w)),L&&k.sida(M),Q._cf(a.c.n(A,w)),x.d(Q)||z.Q(k),L&&k.sida(O));0==z.e&&z.O(-I.x,-I.y)}}null!=O&&O._d();M._d();v||(y.q(-p.x,-p.y),this.r._cf(y),this.o._cf(p))},ieJ:function(a,p){x.c(a,p,"Paint",this.o);x.c(a,p,"Draw",this.r)},v:function(a){this.q=a}};M._dt("CWAA",G,0,w.ieI);k=function p(){p._ic();
this.b=this.c=this.e=null;this._0_3()};v.Annotations=k;k.prototype={_0_3:function(){this.a=(new M)._01_3(this);return this},getList:function(){return this.a},f:function(){if(null==this.b){var a=this.c.iaA();this.b=(new w.bm)._01bm(a,!0)}return this.b},icq:function(p){this.c=p;this.e=a.V.D(p,w.Chart);for(var k=0,m=this.a.L.A,v=m.length,x=0;x<v;x++){var y=m[x];this.a.v(k);y.M(this);k++}return null==p},g:function(){var p=this.a.q;return a.b.k(a.aI.e(),"{0}",p)},ieE:function(a,k,m,v,w){this.b=a;this.a.t(a,
k._nc(),m,!1,v,w);this.b=null;return!1},ieF:function(a,k,m,v,w){return!1},ieG:function(a,k,m,v,w){this.b=a;this.a.t(a,k._nc(),m,!0,v,w);this.b=null;return!1},ieH:function(a,k,m){return!1},d:function(){null!=this.e&&this.e.iM()},ieJ:function(k,m){var v=0,w=0,w=m.ieN();if(0==(m.ieO()&2)){var x=new a._p1(v);m.ieY(x,"_Build",v);v=x.a}m.sieN(v);0!=(m.ieM()&512)&&(this.a=m.ie3("List",this.a,"AnnotationList",580));m.sieN(w);k||this.a.sb(this)}};k._dt("CWAA",a.SA,0,w.icp,w.ieD,w.ieI)})();
