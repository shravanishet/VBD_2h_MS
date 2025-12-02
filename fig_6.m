clc; clear all;  close all;

fig1=figure(1)
set(fig1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32]) 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',3);

d1_e=0.00028;
tf=.2;
t2=1;
sh=1;
egc=4.0;
pf=0.95;
mu=0.5;
sr=.1; 
gh=[1];
gc=[1];
    wrr=0:.01:2; 
    wrr1=2:.01:5;
    for i=1:length(wrr)
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
 hold off
 ylim([0 1])
 xlim([-0.5 5])
xlabel ('Inverse trade-off strength ($\chi$)','Interpreter','latex','FontSize',15,'FontWeight','bold','Rotation',0);
ylabel ('Evolutionary singular strategy $(\sigma_{h2}^{*})$','Interpreter','latex','FontSize',15,'Rotation',90,'FontWeight','bold');    
 box on
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
 ax.FontWeight="bold";
hold on
xline(2,LineStyle="--",LineWidth=2)
