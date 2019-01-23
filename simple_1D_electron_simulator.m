function [] = simple_1D_electron_simulator()
% Variables
    global C
    C.q_0 = 1.60217653e-19;             % electron charge
    C.hb = 1.054571596e-34;             % Dirac constant
    C.h = C.hb * 2 * pi;                % Planck constant
    C.m_0 = 9.10938215e-31;             % electron mass
    C.kb = 1.3806504e-23;               % Boltzmann constant
    C.eps_0 = 8.854187817e-12;          % vacuum permittivity
    C.mu_0 = 1.2566370614e-6;           % vacuum permeability
    C.c = 299792458;                    % speed of light
    C.g = 9.80665;                      % metres (32.1740 ft) per s²
    
    time_steps = 100;
    
% Initialization
force = 5e-27;
electron = [0 0]; 
acceleration1 = force/C.m_0;
acceleration2 = force/C.m_0;
acceleration3 = force/C.m_0;
electron1(1) = 0; %position
electron1(2) = 0; %velocity
electron2(1) = 0; %position
electron2(2) = 0; %velocity
electron3(1) = 0; %position
electron3(2) = 0; %velocity

vf1 = 0;
xf1 = 0;
vf2 = 0;
xf2 = 0;
vf3 = 0;
xf3 = 0;
simTime = 0.001;
drift_velocity1 = 0;
drift_velocity2 = 0;
drift_velocity3 = 0;
average_drift_velocity1 = 0;
average_drift_velocity2 = 0;
average_drift_velocity3 = 0;

figure(1)
clf

for z = 2:time_steps
    r1 = rand;
    r2 = rand;
    r3 = rand;
    r11 = rand;
    r22 = rand;
    r33 = rand;
    if r1 <= 0.04
        if r11 <=0.5
            acceleration1 = acceleration1*1.25;
        else
            acceleration1 = acceleration1*0.75;
        end
        vf1 = 0;
    else
        vf1 = electron1(2) + acceleration1*simTime;
    end
    xf1 = electron1(1) + vf1*simTime;
    
    
    if r2 <= 0.04
        if r22 <=0.5
            acceleration2 = acceleration2*1.25;
        else
            acceleration2 = acceleration2*0.75;
        end
        vf2 = 0;
    else
        vf2 = electron2(2) + acceleration2*simTime;
    end
    xf2 = electron2(1) + vf2*simTime;
    
    
    if r3 <= 0.04
        if r33 <=0.5
            acceleration3 = acceleration3*1.25;
        else
            acceleration3 = acceleration3*0.75;
        end
        vf3 = 0;
    else
        vf3 = electron3(2) + acceleration3*simTime;
    end
    xf3 = electron3(1) + vf3*simTime;

    electron1(2) = vf1;
    electron1(1) = xf1;
    electron2(2) = vf2;
    electron2(1) = xf2;
    electron3(2) = vf3;
    electron3(1) = xf3;
    
    drift_velocity1 = drift_velocity1 + vf1;
    drift_velocity2 = drift_velocity2 + vf2;
    drift_velocity3 = drift_velocity3 + vf3;
    
    average_drift_velocity1 = drift_velocity1/z;
    average_drift_velocity2 = drift_velocity2/z;
    average_drift_velocity3 = drift_velocity3/z;
    plot(xf1, 0.6, 'ro')
    hold on
    plot(xf2, 0, 'bo')
    hold on
    plot(xf3, -0.6, 'go')
    
    xlim([0, 5]);
    ylim([-1 1]);
    title('Racing Electrons');
    legend(strcat('Drift Velocity 1 = ', num2str(round(average_drift_velocity1*100)/100),' m/s'), ...
        strcat('Drift Velocity 2 = ', num2str(round(average_drift_velocity2*100)/100),' m/s'),...
        strcat('Drift Velocity 3 = ', num2str(round(average_drift_velocity3*100)/100),' m/s')); 
    hold on
    pause(.1)
end

end
