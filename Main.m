clear all
close all
clc

NSUs = 30;
repeats = 10;
for i = 1:length(NSUs)
    NSU = NSUs(i);
    disp(NSUs(i))
    for j = 1:repeats
        all(j).result = runOPT(NSU);
%         filename = ['Solutions/WithConstraint/NoiseCheck_', num2str(NSUs(i)), 'SUs', num2str(j), '.mat'];
%         save(filename, 'result')
        
    end
end

[RMS, obj] = deal(zeros(length(all(1).result),repeats));
for j = 1:repeats
    result = all(j).result;
    T = result(end).params.T;
    h = T/(result(end).params.NperSU-1);
    for i = 1:length(all(1).result)
        obj(i,j) = result(i).obj;
        K(:,i,j) = result(i).X(end-1:end);
        [uperSU, uall,meanxx] = plotresult(result(i), 0);
        meanu(:,i,j) = mean(uall,3);
        stdu(:,i,j) = std(uall,[],3);
        meanx(i,:,j) = meanxx(1,:);
        rmsu = rms(uall);
        RMS(i,j) = mean(rmsu(:));
   end
end

figure
subplot(2,1,1)
meantrajs = mean(meanx,3);
stdtrajs = std(meanx,[],3);
plot([0:h:T], meantrajs([1 4:end],:)', 'linewidth', 1.5)
legend('sigma = 0 rad/s2', 'sigma = 5e-2  rad/s2', 'sigma = 1e-1  rad/s2', 'sigma = 5e-1  rad/s2', 'sigma = 1  rad/s2')
xlabel('Time [s]')
ylabel('Arm Angle [rad]')

subplot(2,1,2)
meantorque = mean(meanu,3);
stdtorque = mean(stdu,3);
plot([0:h:T], meantorque(:,1), 'r', 'linewidth', 1.5)
hold on
errorbar([0:h:T], meantorque(:,end),stdtorque(:,end), 'k', 'linewidth', 1.5)
legend('sigma = 0', 'sigma = 1')% 'FontSize', 12)
xlabel('Time [s]')
ylabel('Input u_0+ K x  [Nm]')
xlim([0 10])
