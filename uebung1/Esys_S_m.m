function Esys_S_m(block)

% Simulationsmodell für das elektrische Netzwerk
%
% -------------------------------------------------------------------------
%
% Beschreibung: Simulationsmodell des elektrischen Netzwerks
%               Regelungstechnik Laborübung für Technische Informatik
%               Aufgabe 1.5.1: Vervollstaendigen Sie die durch "TODO"
%                              gekennzeichneten Programmteile.
%
% -------------------------------------------------------------------------
%
% Eingaenge:    u1(1) ... Ue   Eingangsspannung [V]
%               u2(1) ... Us   Stoerspannung [V]
%
% Zustaende:    x(1)  ... UC1  Spannung an nichtlinearer Kapazitaet C1 [V]
%               x(2)  ... UC2  Spannung an linearer Kapazitaet C2 [V]
%
% Ausgaenge:    y1(1) ... UC1  Spannung an nichtlinearer Kapazitaet C1 [V]
%               y1(2) ... UC2  Spannung an linearer Kapazitaet C2 [V]
%
%               y2(1) ... C1   Differentielle Kapazitaet C1 [F]
%
%               y3(1) ... Ua   Ausgangsspannung [V]
%
% Parameter: 
%           p(1)... UC1_0    Anfangswert UC1
%           p(2)... UC2_0    Anfangswert UC2
%           p(3)... R1       Widerstand
%           p(4)... R2       Widerstand
%           p(5)... K        Spannungsverstärkung
%           p(6)... C1_ref   Parameter der nichlinearen Kapazitaet C1
%           p(7)... UC1_ref  Parameter der nichlinearen Kapazitaet C1
%           p(8)... kC1      Parameter der nichlinearen Kapazitaet C1
%           p(9)... C2       Kapazitaet
%
% -------------------------------------------------------------------------
% Abtastzeit (sample time): zeitkontinuierlich (continuous)
% -------------------------------------------------------------------------


% Die Funktion setup (s.u.) dient der Initialiserung des Matlab Objektes
% (block). Im Objekt block sind alle fuer die Simulation in Simulink
% notwendigen Eigenschaften (Eingaenge, Zustaende, Ausgaenge, Parameter,
% usw.) des dynamischen Systems (math. Modell) zusammengefasst.
setup(block);

% -------------------------------------------------------------------------
% Initialisierung des Simulationsobjektes block
% -------------------------------------------------------------------------

function setup(block)
  
  % Anzahl der Eingangs- und Ausgangsports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 3;
  
  % Anzahl der zeitkontinuierlichen Zustaende
  block.NumContStates = 2;

  % Anzahl der Parameter
  block.NumDialogPrms = 9;
  
  % Dimensionen der Eingangsports
  % Flag DirectFeedthrough kennzeichnet, ob ein Eingang direkt an einem
  % Ausgang auftritt, d.h. y=f(u)
  block.InputPort(1).Dimensions        = 2;
  block.InputPort(1).SamplingMode = 'Sample';
  block.InputPort(1).DirectFeedthrough = false;

  % Dimensionen der Ausgangsports  
  block.OutputPort(1).Dimensions       = 2;
  block.OutputPort(1).SamplingMode = 'Sample';
  block.OutputPort(2).Dimensions       = 1;
  block.OutputPort(2).SamplingMode = 'Sample';
  block.OutputPort(3).Dimensions       = 1;
  block.OutputPort(3).SamplingMode = 'Sample';
  
  
  % Einstellen der Abtastzeit: [0 0] wird verwendet fuer die
  % zeitkontinuierliche Simulation.
  block.SampleTimes = [0 0];
  
  % ------------------------------------------------
  % NICHT VERAENDERN
  % ------------------------------------------------
  % 
  % Registrieren der einzelnen Methoden
  % Hier: InitializeConditions ... Initialisierung
  %       Outputs ...       Berechnung der Ausgaenge
  %       Derivatives ...   Berechnung der Zustaende
  %       Terminate ...     Konsistentes Beenden der Simulation

  block.RegBlockMethod('InitializeConditions',    @InitConditions); 
  block.RegBlockMethod('Outputs',                 @Output);  
  block.RegBlockMethod('Derivatives',             @Derivatives);  
  block.RegBlockMethod('Terminate',               @Terminate);


% -------------------------------------------------------------------------
% Setzen der Anfangsbedingungen der Zustaende
% -------------------------------------------------------------------------

function InitConditions(block)
  
  % Einlesen der Parameter des Systems
  UC1_0 = block.DialogPrm(1).Data;
  UC2_0 = block.DialogPrm(2).Data;
  
  % Eingabe der Anfangsbedingungen
  x0(1) = UC1_0;
  x0(2) = UC2_0;
  
  % Schreiben auf Objekt block (NICHT VERAENDERN)
  block.ContStates.Data = x0;


% -------------------------------------------------------------------------
% Berechnen der Ausgaenge
% -------------------------------------------------------------------------

function Output(block)

  % Einlesen der Parameter des Systems
  K       = block.DialogPrm(5).Data;
  C1_ref  = block.DialogPrm(6).Data;
  UC1_ref = block.DialogPrm(7).Data;
  kC1     = block.DialogPrm(8).Data;
   
  % Shortcut fuer den Zustand
  x = block.ContStates.Data;
  UC1 = x(1);
  UC2 = x(2);

  % Berechnung der Ausgaenge
  % Port 1:
  y1(1) = UC1;
  y1(2) = UC2;
  
  % TODO: Port 2:
  C1 = ; % Aktueller Wert der differentiellen Kapazitaet C1
  y2(1) = C1;
  
  % TODO: Port 3:
  Ua = ; % Ausgangsspannung
  y3(1) = Ua; 
  
  % Schreiben auf Objekt block
  block.OutputPort(1).Data = y1;
  block.OutputPort(2).Data = y2;
  block.OutputPort(3).Data = y3;
  

% -------------------------------------------------------------------------
% Berechnen der Zustaende
% -------------------------------------------------------------------------

function Derivatives(block)

  % Einlesen der Parameter des Systems
  R1      = block.DialogPrm(3).Data;
  R2      = block.DialogPrm(4).Data;
  K       = block.DialogPrm(5).Data;
  C1_ref  = block.DialogPrm(6).Data;
  UC1_ref = block.DialogPrm(7).Data;
  kC1     = block.DialogPrm(8).Data;
  C2      = block.DialogPrm(9).Data;
  
  % Shortcut fuer den Eingang
  u = block.InputPort(1).Data;
  Ue = u(1);
  Us = u(2);
  
  % Shortcut fuer die Zustaende
  x = block.ContStates.Data;
  UC1 = x(1);
  UC2 = x(2);
  
  % TODO: Erste Ableitung von Q1 nach UC1
  dQ1 = ;
  
  % TODO: Berechnen der Zeitableitungen der Zustaende
  dx(1) = ;
  dx(2) = ;
  
  % Schreiben auf Objekt block
  block.Derivatives.Data = dx;


% -------------------------------------------------------------------------
% Operationen am Ende der Simulation
% -------------------------------------------------------------------------

% Die function Terminate wird hier nicht verwendet,
% muss aber vorhanden sein!
function Terminate(block)

