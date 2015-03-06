function play(w,w_t,k,record,step)    
    a = size(w);
    N = a(3);
    zero_tol = 1.0e-10; % criteria for determining support of a source
    nonzero_tol = 0.5;
    
    if nargin < 4
        record  = 0;
    end
    if nargin < 5
        step = 0.1;
    end
    figure('units','normalized','outerposition',[0 0 1 1]), set(gcf, 'Color','white');     
    colormap(bone);
    
    n = 1;
    
    subplot(1,2,1); imagesc(w(:,:,n)); caxis([-0.25,0.25]); title('Displacement','FontName','lucidabright','FontSize',16); set(gca,'XTick',[],'YTick',[]); hold on;
    subplot(1,2,2); imagesc(w_t(:,:,n)); caxis([-0.5,0.5]); title('Velocity','FontName','lucidabright','FontSize',16); xlabel(sprintf('t=%2.2f',n*k),'FontName','lucidabright','FontSize',16); set(gca,'XTick',[],'YTick',[]); hold on;
    
    
    if record > 0
        frame = 401*(record - 1) + n;
        filename = sprintf('movie/frame%04d',frame);
        print('-dpng',filename);
    else
        drawnow;
    end
        
    for n = 2 : N              
        subplot(1,2,1); imagesc(w(:,:,n));% caxis([-0.25,0.25]); title('Displacement','FontName','lucidabright','FontSize',16); set(gca,'XTick',[],'YTick',[]); hold on;
        subplot(1,2,2); imagesc(w_t(:,:,n)); xlabel(sprintf('t=%2.2f',n*k),'FontName','lucidabright','FontSize',16); % caxis([-0.5,0.5]); title('Velocity','FontName','lucidabright','FontSize',16); xlabel(sprintf('t=%2.2f',n*k),'FontName','lucidabright','FontSize',16); set(gca,'XTick',[],'YTick',[]); %hold on;
        
        %suptitle(sprintf('t=%2.2f',n*k));
        if record > 0
            frame = 401*(record - 1) + n;
            filename = sprintf('movie/frame%04d',frame);
            print('-dpng',filename);
        else
            drawnow;
        end
    end 
    close(gcf);
end
