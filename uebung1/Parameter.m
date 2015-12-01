% Parameterfiles fuer das Simulink Modell des elektrischen Systems 
% (Aufgabe 1.4 und 1.5)
close all;
clear all;
clc;

% Parameter
R1      = 625;    % Widerstand in Ohm
R2      = 3500;   % Widerstand in Ohm
K       = 3;      % Spannungsverst‰rkung
C1_ref  = 1e-6;   % Referenz-Kapazit‰tswert auf Kennlinie von C1 in F
UC1_ref = -10;    % Referenz-Spannungswert auf Kennlinie von C1 in V
kC1     = 800e-9; % Steigung der Kennlinie von C1 in F/V
C2      = 1e-6;   % Kapazit‰t in F

% Festlegung der Ruhelage in Volt
UeR = 5;
UsR = 5;

%% Eingangsspannung und Stoerspannung (Aufgabe 1.5)
% Sprungfoermige Eingangsspannung
te = 1;      % Einschaltzeitpunkt in Sekunden
Ue = 7;      % Endwert des Sprunges in Volt

% Sinusfoermige Eingangsspannung
Usinus = 0.1; % Amplitude des Sinus in Volt
we     = 10;  % Winkelfrequenz des Sinus in rad/s

% Sprungfoermige Stoerspannung
ts = 3;     % Einschaltzeitpunkt in Sekunden
Us = 1;     % Endwert des Sprunges in Volt

%% Modell des linearisierten Systems

% Aufgabe 1.4.4
% -------------
% Errechnen Sie die Ruhelage des Systems!
% UC1R = ;
% UC2R = ;
% UaR  = ;

% Errechnen Sie f¸r die gegebene Ruhelage die Ableitungen der in C1 
% gespeicherter Ladung Q1 nach der anliegenden Spannung!
% dQ1  = ; % Erste Ableitung von Q1 nach UC1
% ddQ1 = ; % Zweite Ableitung von Q1 nach UC1

% Ergaenzen Sie die Systemmatrix A (Asys), die Eingangsvektoren bu (busys)
% und bd (bdsys) sowie den Ausgangsvektor c (csys) und den Durchgriff d (dsys)
% f¸r das linearisierte System!

% A11 = ;
% A12 = ;
% A21 = ;
% A22 = ;

% A  = [A11,A12;A21,A22];
% bu = [];
% bd = [];
% c  = [];
% du = [];
% dd = [];
%% Uebertragungsfunktion G (Eingang u -> Ausgang y) und Uebertragungsfunktion Gd (Stoerung d -> Ausgang y)

% Aufgabe 1.4.4
% -------------
% Bestimmen Sie zun‰chst eine MISO- oder zwei SISO-Zustandsraum- 
% darstellungen mittels ss(). Anschlieﬂend koennen Sie in beiden Faellen
% die gesuchten ‹bertragungsfunktionen (G und Gd) mittels tf() bestimmen.

% G  = ;
% Gd = ;

%% Verstaerkungsfaktor V, Daempfungsgrad xi und Zeitkonstante T von G

% Aufgabe 1.4.5
% -------------
% Bestimmen Sie den Verstaerkungsfaktor V, den Daempfungsgrad xi und die
% Zeitkonstante T der ‹bertragungsfunktion G. 

% V  = ;
% T  = ;
% xi = ;

%% Bodediagramme der Uebertragungsfunktionen G und Gd

% Aufgabe 1.4.6
% -------------
% Zeichnen und interpretieren Sie die Bodediagramme der beiden
% Uebertragungsfunktionen G und Gd. Verwenden Sie dazu den Befehl bode().