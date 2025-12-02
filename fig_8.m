clc; clear all;  close all;
global  T bhv bvh v d3 M del1 d1 d2 mu1 Nh1 Nh2  

  T=1000;
  bhv=.5;    %%beta_vh
  bvh=.5;    %%beta_vh
  v=1;      %%v biting rate
  mu1=0.5;
  d1=.5;     %%death rate of host1 (human)
  d2=0.01;   %%death rate of host2
  del1=0.5;  % rate of waning immunity for h1
  d3=.8;    %%death rate of vector
  Nh1=3000;    %Total population
  Nh2=1000;
  M=15000; 

 xticks = [0,0.5,1.5, 2];
 yticks = [0,0.5,1,1.5,2];

AlphaV=0.01:.01:2;
compt=0.01:.01:2;

i_index = find(compt == 1);
j_index = find(AlphaV == 1);

  for i=1:length(compt)
          del2=(mu1+d1).*compt(i) - d2;
      for j=1:length(AlphaV)
          av=AlphaV(j);
          [INF1(i,j)] = computeZ(del2, av);
      end
  end
HOST1=sign(INF1-INF1(i_index,j_index));
raw_custom_map = [0 0 1; 1 1 1; 1 0 0];
nColors = 3;   
x = [1, 2, 3];  
xi = linspace(1, 3, nColors);
custom_color_map_interp = interp1(x, raw_custom_map, xi);
alphaValue = 0.5;

fig = figure;
set(fig,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])  
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);

gap = [0.09 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.08 0.08]; % Margins in height (bottom/top)
marg_w = [0.04 0.01]; % Margins in width (left/right)
[ha, pos] = tight_subplot(1, 1, gap, marg_h, marg_w);

figBackgroundColor = get(fig, 'Color');  
hpq1= imagesc(compt, AlphaV, transpose(HOST1));
set(hpq1, 'AlphaData', alphaValue);
set(gca,'YDir','normal');
set(gca,'XDir','normal');

color_cus = alphaValue * custom_color_map_interp + ...
         (1 - alphaValue) * repmat(figBackgroundColor, size(custom_color_map_interp, 1), 1);
    
colormap(color_cus);
set(hpq1, 'AlphaData', 1);
    
hold on
  plot([1 1], get(gca,'YLim'), 'k', 'LineWidth', 2);
  hold on
  plot(get(gca,'XLim'),[1 1], 'k', 'LineWidth', 2);
  hold on
 set(gca,'XTick',[],'YTick',[])
xlabel('Vector preference ($\alpha_{v}$)','Interpreter','latex')
ylabel('Host competence ($\gamma$)','Interpreter','latex','Rotation',90)


for k = 1:length(xticks)
    text(xticks(k), 0.99, num2str(xticks(k)), ...
         'HorizontalAlignment','center', 'VerticalAlignment','top', 'FontSize',12,'Interpreter','latex');
end

for k = 1:length(yticks)
    text(1.15, yticks(k), num2str(yticks(k)), ...
         'HorizontalAlignment','right', 'VerticalAlignment','middle', 'FontSize',12,'Interpreter','latex');
end

text(1.5, 1.1, 'competent $h1$', 'HorizontalAlignment','center','Interpreter','latex');
text(0.5, 1.1, 'competent $h2$', 'HorizontalAlignment','center','Interpreter','latex');
text(0.96,1.5, ' prefer $h1$', 'HorizontalAlignment','center','Interpreter','latex',Rotation=90);
text( 0.96,0.5, ' prefer $h2$', 'HorizontalAlignment','center','Interpreter','latex',Rotation=90);

function [IN1] = computeZ(del2,av)
global  T bhv bvh v d3 M del1 d1 d2 mu1 Nh1 Nh2
      c1=bhv.*v.*M./(av.*Nh1+Nh2);
      c2=bvh.*v./(av.*Nh1+Nh2);
      h=@(t,p)[(av*c1*p(3)*(1-p(1)-p(4)))-(mu1+d1)*p(1);        %Inf host1
      c1*p(3)*(1-p(2))-(d2+del2)*p(2);          %Inf host2
      (c2*(av*Nh1*p(1)+ Nh2*p(2))*(1-p(3)))-d3*p(3);        %Inf vect
      mu1*p(1)-(d1+del1)*p(4)];                          %Recovered host1
[~,W]=ode89(h,[0 T],[ 0.001 0.001 0.001 0 ]);
IH1=W(:,1); 
IN1=IH1(end);
  end
