%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Plot singularity 
%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all;  close all;
Titlew={'Relative Encounter rate $\ll 1$','Relative Encounter rate $< \approx 1$',...
  'Relative Encounter rate $\gg 1$','Relative Encounter rate  $ > \approx 1$'};
 
fig1=figure(1)
set(fig1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',3);

gap = [0.1 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.05 0.05]; % Margins in height (bottom/top)
marg_w = [0.09 0.01]; % Margins in width (left/right)
[ha, pos] = tight_subplot(2, 2, gap, marg_h, marg_w);


d1_e=0.00028;
tf=.1;
t2=2.5;
sh=1;
egc=5.0;
pf=0.95;
mu=0.5;
sr=.95; %%%taken from ppr Menach 2007 


 gh1=[2,  1.05, 1,    1];
 gc1=[1,  1,    1.5, 5];

wrr=0:.01:2;  
wrr1=2:.01:5;


for jn=1:length(gh1)
    gh=gh1(jn);
    gc=gc1(jn);
    axes(ha(jn)); 
    for i=1:length(wrr)
        w=wrr(i)
        syms scr 
        psi=1-exp(-(sh.*gh+scr.*gc));
        phs=psi.*pf./(1-((1-psi).*pf));
        Q=scr.*gc./(gh+scr.*gc);
        pc=1-mu.*((1-Q).^(w));
        ph=1-mu.*((Q).^(w));
        sf=phs.*((Q).*pc+(1-Q).*ph);
        pgc=sf.*sr;
        t1=tf./(1-(1-psi).*pf);
        f=1./(t1+t2);
        eps=egc.*(f);
        pd=pgc.^(f);
        diff_pd=diff(f.*log(pgc),scr);
        diff_ep=diff(eps,scr);
        deri=diff_pd+diff_ep;
        eqn=deri==0;
        singular{i}=vpasolve(eqn,scr,0.1);

         if singular{1,i}>0
             sing(i)=singular{1,i};
         else
             sing(i)=0;
         end
    end 
 
 for j=1:length(wrr1)
     j
     w1=wrr1(j)
     syms scr1 
     psi1=1-exp(-(sh.*gh+scr1.*gc));
     phs1=psi1.*pf./(1-((1-psi1).*pf));
     Q1=scr1.*gc./(gh+scr1.*gc);
     pc1=1-mu.*((1-Q1).^(w1));
     ph1=1-mu.*((Q1).^(w1));
     sf1=phs1.*((Q1).*pc1+(1-Q1).*ph1);
     pgc1=sf1.*sr;
     t11=tf./(1-(1-psi1).*pf);
     f1=1./(t11+t2);
     eps1=egc.*(f1);
     diff_pd1=diff(f1.*log(pgc1),scr1);
     diff_ep1=diff(eps1,scr1);
     deri1=diff_pd1+diff_ep1;
     eqn1=deri1==0;
     singular1{j}=vpasolve(eqn1,scr1);

    if singular1{1,j}>0
        sing1(j)=singular1{1,j};
    else
        sing1(j)=0;
    end
 end


 chi_value=[wrr wrr1];
 ESS_value=[sing sing1];
 plot(chi_value,ESS_value,Color='#0072BD')
  title(Titlew{jn}, 'Interpreter', 'latex', 'FontSize', 12);
 hold off
 ylim([0 1])
 xlim([-0.5 5])
 
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)

vs = get(gca, 'YLabel');
posv = get(vs, 'Position');
posv(1) = posv(1) ;
set(vs, 'Position', posv)

xlabel ('Trade-off strength ($\chi$)','Interpreter','latex','FontSize',12,'FontWeight','bold','Rotation',0);
ylabel ('Evolutionary singular strategy $(\sigma_{h2}^{*})$','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
    
 box on
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
 ax.FontWeight="bold";
end
  AddLetters2Plots(fig1, 'HShift', -0.08, 'VShift', -0.02)
