%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Einführung in Matlab/Simulink
% 
% Regelungstechnik Übung
% Institut für Automatisierungstechnik 
% Gruppe für komplexe dynamische Systeme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameter

clear all
close all 
clc

T  = 0.5;
xi = 0.2;
V  = 2;
Ta = 0.1;

% 1. Möglichkeit: Übertragungsfunktion

G_tf = tf([V],[T^2 2*xi*T 1])

G_z  = c2d(G_tf,Ta,'zoh')

% 2. Möglichkeit: Zustandsraumdarstellung

A = [0 1; -1/T^2 -2*xi/T];
B = [0;V/T^2];
C = [1,0];
D = 0;

sys = ss(A,B,C,D)

