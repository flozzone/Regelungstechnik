function test_sfunc_m(block)

% Musterbeispiel level-2 Matlab M-file s-function
%
% -------------------------------------------------------------------------
%
% Beschreibung: Beispiel einer level-2 Matlab M-file s-function zur
%               Simulation des dynamischen Verhaltens eines einfachen
%               Systems; 
% -------------------------------------------------------------------------
%
% Eingaenge:    u1(1) ... u1
%
%               u2(1) ... u2
%
% Zustaende:    x(1)  ... x1
%               x(2)  ... x2
%
% Ausgaenge:    y1(1) ... x(1)
%               y1(2) ... x(2)
%
%               y2(1) ... exp(x1)*cosh(x2)
%
% Parameter:    p(1)  ... a
%               p(2)  ... b
%               p(3)  ... Vektor der Anfangswerte x0 ([x(1),x(2)] fuer t=0)
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
  block.NumInputPorts  = 2;
  block.NumOutputPorts = 2;
  
  % Anzahl der zeitkontinuierlichen Zustaende
  block.NumContStates = 2;

  % Anzahl der Parameter
  block.NumDialogPrms = 3;
  
  % Dimensionen der Eingangsports
  % Flag DirectFeedthrough kennzeichnet, ob ein Eingang direkt an einem
  % Ausgang auftritt, d.h. y=f(u)
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).SamplingMode = 'Sample';
  block.InputPort(1).DirectFeedthrough = false;
  block.InputPort(2).Dimensions        = 1;
  block.InputPort(2).SamplingMode = 'Sample';
  block.InputPort(2).DirectFeedthrough = false;

  % Dimensionen der Ausgangsports  
  block.OutputPort(1).Dimensions       = 2;
  block.OutputPort(1).SamplingMode = 'Sample';
  block.OutputPort(2).Dimensions       = 1;
  block.OutputPort(2).SamplingMode = 'Sample';
  
  
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
%  a   = block.DialogPrm(1).Data; % bei Bedarf
%  b   = block.DialogPrm(2).Data;
  x0 = block.DialogPrm(3).Data;
  
  % Eingabe der Anfangsbedingungen
  x=x0;
  
  % Schreiben auf Objekt block (NICHT VERAENDERN)
  block.ContStates.Data = x;


% -------------------------------------------------------------------------
% Berechnen der Ausgaenge
% -------------------------------------------------------------------------

function Output(block)

  % Einlesen der Parameter des Systems
%   a   = block.DialogPrm(1).Data; % bei Bedarf
%   b   = block.DialogPrm(2).Data;
   
  % Shortcut fuer den Eingang
%   u1 = block.InputPort(1).Data; % bei Bedarf
%   u2 = block.InputPort(2).Data;
  
  % Shortcut fuer den Zustand
  x = block.ContStates.Data;

  % Berechnung der Ausgaenge
  % Port 1:
  y1(1) = x(1);
  y1(2) = x(2);
  
  % Port 2:
  y2(1) = exp(x(1))*cosh(x(2));
  
  % Schreiben auf Objekt block
  block.OutputPort(1).Data = y1;
  block.OutputPort(2).Data = y2;
  

% -------------------------------------------------------------------------
% Berechnen der Zustaende
% -------------------------------------------------------------------------

function Derivatives(block)

  % Einlesen der Parameter des Systems
  a   = block.DialogPrm(1).Data;
  b   = block.DialogPrm(2).Data;
  
  % Shortcut fuer den Eingang
  u1 = block.InputPort(1).Data;
  u2 = block.InputPort(2).Data;
  
  % Shortcut fuer die Zustaende
  x = block.ContStates.Data;
  
  % Berechnen der Zeitableitungen der Zustaende
  dx(1) = -x(2)+sin(u1(1));
  dx(2) = a*x(1)+b*u2(1);
  
  % Schreiben auf Objekt block
  block.Derivatives.Data = dx;


% -------------------------------------------------------------------------
% Operationen am Ende der Simulation
% -------------------------------------------------------------------------

% Die function Terminate wird hier nicht verwendet,
% muss aber vorhanden sein!
function Terminate(block)

