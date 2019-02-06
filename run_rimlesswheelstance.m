%run_rimlesswheelstance
% Sayed Thangal 23 Jan 2019
% Code to run rimlesswheelstance_startercode and process outputs

clear all;close all;clc
%%
% Default parms within startercode
 parms = struct('alpha', 0.3, 'rgyr', 0, 'gamma', 0.04, 'tmax', 5);
% New parms
steps=20;
x0 = [0.3; -0.4];
[xe,te,xs,ts,energies] = rimlesswheelstance(x0, parms);

xs_diff=[xs(:,2),sin(xs(:,1)-parms.gamma)];
%xs_diff2=[diff(xs)./diff(ts)];
%%
nam=['Rimless wheel angle, angular velocity, energy'];
figure('name',nam)

subplot(3,1,1)
plot(ts,xs(:,1),'r.-')
ylabel ('angle (rad)')
grid on;
subplot(3,1,2)
plot(ts,xs(:,2),'b.-')
ylabel('Angvel (rad)')
grid on;
subplot(3,1,3)
hold on;
plot(ts,energies.total,'k.-')
plot(ts,energies.PE,'m.-')
plot(ts,energies.KE,'y.-')
legend('Total','PE','KE')
ylabel('Energies')
xlabel('time')
grid on;

nam=['Phase plot with derivatives'];
figure('name',nam)
hold on;
plot(xs(:,1),xs(:,2),'r.-')
quiver(xs(:,1),xs(:,2),xs_diff(:,1),xs_diff(:,2));
grid on;
xlabel('angle (rad)')
ylabel('Angular velocity (rad/sec)')

%% mulitple steps
for n=1:steps
        new_vel=xs(end,2)*cos(2*parms.alpha);
        x0=[parms.alpha,new_vel];
        [xe_new,te_new,xs_new,ts_new,energies_new] = rimlesswheelstance(x0, parms);
        xs=[xs;xs_new];
        ts=[ts;ts(end)+ts_new];
        energies.total=[energies.total;energies_new.total];
        energies.PE=[ energies.PE;energies_new.PE];
        energies.KE=[ energies.KE;energies_new.KE];

end
xs_diff=[xs(:,2),sin(xs(:,1)-parms.gamma)];
nam=['Rimless wheel angle, angular velocity, energy-multiple steps'];
figure('name',nam)
subplot(3,1,1)
plot(ts,xs(:,1),'r.-')
ylabel ('angle (rad)')
grid on;
subplot(3,1,2)
plot(ts,xs(:,2),'b.-')
ylabel('Angvel (rad)')
grid on;
subplot(3,1,3)
hold on;
plot(ts,energies.total,'k.-')
plot(ts,energies.PE,'m.-')
plot(ts,energies.KE,'y.-')
legend('Total','PE','KE')
ylabel('Energies')
xlabel('time')
grid on;

nam=['Phase plot with derivatives-multiple steps'];
figure('name',nam)
hold on;
plot(xs(:,1),xs(:,2),'r.-')
quiver(xs(:,1),xs(:,2),xs_diff(:,1),xs_diff(:,2));
grid on;
xlabel('angle (rad)')
ylabel('Angular velocity (rad/sec)')