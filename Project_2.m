function varargout = Project_2(varargin)
% PROJECT_2 MATLAB code for Project_2.fig
%      PROJECT_2, by itself, creates a new PROJECT_2 or raises the existing
%      singleton*.
%
%      H = PROJECT_2 returns the handle to a new PROJECT_2 or the handle to
%      the existing singleton*.
%
%      PROJECT_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT_2.M with the given input arguments.
%
%      PROJECT_2('Property','Value',...) creates a new PROJECT_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project_2

% Last Modified by GUIDE v2.5 12-Nov-2019 14:48:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Project_2 is made visible.
function Project_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project_2 (see VARARGIN)

% Choose default command line output for Project_2
handles.output = hObject;

% creates an object of the robot class and stores it in handles.rc
%struct property.
handles.rc = Robot_class();

clc
% This code is needed to make sure our variables retain there values
% in other functions 
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Project_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Joint_1_Callback(hObject, eventdata, handles)

% This code will grab the value of our slider position and store it to our
% structs variable theta(1)
handles.rc.theta(1) = get(hObject,'Value');
y = handles.rc.map_fn(handles.rc.theta(1),-0.261799388,3.18522588); 
handles.rc.movePosition(handles.rc.s1,y)

% with the new theta value we will plot our robot with the new angle 
handles.rc.robot.plot(-handles.rc.theta);
%joint1_position = readPosition(handles.s1)
% The code below will be used to update end effector x position in 
% real time as we move the slider
T = handles.rc.robot.fkine(-handles.rc.theta);
X = sprintf('X = %f', T.t(1));
set(handles.x_func,'String',X);
drawnow();

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Joint_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Joint_2_Callback(hObject, eventdata, handles)

% This code will grab the value of our slider position and store it to our
% structs variable theta(2)
handles.rc.theta(2) = get(hObject,'Value');
y  = handles.rc.map_fn(handles.rc.theta(2),-3.18522588,0.261799388); 
handles.rc.movePosition(handles.rc.s2,y)

% with the new theta value we will plot our robot with the new angle 
handles.rc.robot.plot(-handles.rc.theta);

% The code below will be used to update end effector x position in 
% real time as we move the slider
T = handles.rc.robot.fkine(handles.rc.theta);
Y = sprintf('Y = %f', T.t(2));
set(handles.y_func,'String',Y);
drawnow();

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Joint_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Joint_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on slider movement.
function End_Effector_Callback(hObject, eventdata, handles)

% This code will grab the value of our slider position and store it to our
% struct variable theta(3)
handles.rc.theta(3) = get(hObject,'Value');
handles.rc.movePosition(handles.rc.s3,handles.rc.theta(3))

% with the new theta value we will plot our robot with the new angle 
handles.rc.robot.plot(handles.rc.theta);

% The code below will be used to update end effector x position in 
% real time as we move the slider
T = handles.rc.robot.fkine(handles.rc.theta);
Z = sprintf('Z = %f', T.t(3));
set(handles.z_func,'String',Z);
drawnow();
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function End_Effector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to End_Effector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in Create_Robot.
function Create_Robot_Callback(hObject, eventdata, handles)

% Specify the axes to use 
axes(handles.axes1);
% value of our work space to change the floor titles
W = [-5 13.5 0 17.5 -5 5];

% deg will be used to convert degrees to radians 
deg = pi/180;
% By inputting our dh parameters as an argument we will generate each link
L(1) = Link('a', 3.8490,'alpha', 0.0030, 'd', 1.0303, 'offset', 0.1864, 'qlim', [15 -182.5]*deg);
L(2) = Link('a', 3.7936, 'alpha', -0.6883, 'd', 0.7163, 'offset', -0.1017, 'qlim', [182.5 -15]*deg);
L(3) = Link('a', 0.0016  , 'alpha', -0.0008, 'd', 0.2595, 'offset', 0.0087, 'qlim', [0, pi]);
% serial link will be used to help create the robot 
handles.rc.robot = SerialLink(L, 'name', 'robot');
% robotic base that is 8 inches in y direction from universial coordinate 
% to robotic base, similarly for the tool tip  
handles.rc.robot.base = [1 0 0 0; 0 1 0 8; 0 0 1 0; 0 0 0 1];
handles.rc.robot.tool = [1 0 0 0; 0 1 0 0;0 0 1 -2.5; 0 0 0 1];
% below code will plot our robot with the theta values and update
% the floor of our robot with the 'workspace' command 
handles.rc.robot.plot (handles.rc.theta, 'workspace', W);
% create an arduino object and store it to robot class property a
handles.rc.a = arduino('COM3', 'Uno', 'Libraries', 'Servo');
% this code is used to make the pin an input opposed to an output
handles.rc.a.configurePin('D2','DigitalInput');
handles.rc.a.configurePin('D4','DigitalInput');
% create a servo object for each of the motors and inputting its pulse 
% duration range from tech specs from website
handles.rc.s1 = servo(handles.rc.a, 'D9', 'MinPulseDuration', 575*10^-6, 'MaxPulseDuration', 2460*10^-6);
handles.rc.s2 = servo(handles.rc.a, 'D10', 'MinPulseDuration', 575*10^-6, 'MaxPulseDuration', 2460*10^-6);
handles.rc.s3 = servo(handles.rc.a, 'D11', 'MinPulseDuration', 640*10^-6, 'MaxPulseDuration', 2250*10^-6);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Reset_fn.
function Reset_fn_Callback(hObject, eventdata, handles)

% reset the robot back to starting postion by making theta values 0
handles.rc.robot.plot ([0 0 0]);

% choose the physical starting postion of our hardware robot
handles.rc.movePosition(handles.rc.s1,0.1)
handles.rc.movePosition(handles.rc.s2,0.9)

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Key_press.
function Key_press_Callback(hObject, eventdata, handles)

% ignore this function 


% --- Executes on key press with focus on Key_press and none of its controls.
function Key_press_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Key_press (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles structure with handles and user data (see GUIDATA)

% this code will get the current graphic figure

f= gcf;

% m matrix specfies the axis (x,y,and z) and if there are any yaw, pitch, and row
m = [1 1 0 0 0 0];

% val will get the current arrow key from the keyboard, note computer can
% only recongnize numbers so the ascii table assigns a number to each
% keyboard key and this number is what is stored in the val variable

val=double(get(f,'CurrentCharacter'));

%do a forward kinematics
T = handles.rc.robot.fkine([handles.rc.theta(1), handles.rc.theta(2), handles.rc.theta(3)]);
 
% depending on the val value it will run the switch case based on it.
switch (val)

    case 28 % right
        
        T.t(1) = T.t(1) + .1;
        
    case 29  %left
        
        T.t(1) = T.t(1) - .1;
        
    case 30 %up
        
        T.t(2) = T.t(2) + .1;
        
    case 31  %down
        
        T.t(2) = T.t(2) - .1;
        
    otherwise
        
        disp ('unrecognized key');
        
end

% inverse kinematics is used here to get the joint angles which are theta 1
% theta 2 and theta 3. 
q = handles.rc.robot.ikine(T,'q0', handles.rc.theta,'mask', m);

% if q is not empty meaning there is some value in it then we will plot the
% robot and store the new joint angles in our theta values. This is good to
% prevent self assignment and decrease the time complexity of our program. 
if ~isempty(q)
    handles.rc.robot.plot([-q(1) -q(2) q(3)]);
    
    handles.rc.theta(1) = q(1);
    
    handles.rc.theta(2) = q(2);
    
    handles.rc.theta(3) = q(3);
else
    disp ('no solution');
end

% these will cal the Robot_class mapping function which will make each of
% our theta values a range between 0 - 1 because the movePosition function
% can only take values between 0 and 1. 
y1 = handles.rc.map_fn(handles.rc.theta(1),-0.261799388,3.18522588); 
y2 = handles.rc.map_fn(handles.rc.theta(2),-3.18522588,0.261799388); 

% move position is a Robot_class function that calls a servo pre-defined
% function writePosition to move the specfied motor based on s used and
% given a theta value that is mapped between 0 and 1. 
handles.rc.movePosition(handles.rc.s1,y1)
handles.rc.movePosition(handles.rc.s2,y2)

% This code will print out to a text file the pre-condition is that the
% open file function must be called to open the actual file.
fprintf(handles.fileID,'%3.2f %3.2f %3.2f %3.2f\n',handles.rc.getPosition(handles.rc.s1),handles.rc.getPosition(handles.rc.s2), handles.rc.theta(1), handles.rc.theta(2)); % will print it to the text file 

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in File_Open.
function File_Open_Callback(hObject, eventdata, handles)
% opens a  file 
handles.fileID = fopen('joint_angles.txt','a');
% if the file is not empty then display message
if ~isempty(handles.fileID)
    msgbox('File is Open!')
else 
    msgbox('File is not open') % file is empty display message 
end 
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in File_Close.
function File_Close_Callback(hObject, eventdata, handles)
% closes a file 
fclose(handles.fileID); 
msgbox('File is closed!')

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Play_Game.
function Play_Game_Callback(hObject, eventdata, handles)
% code is a buffer to prevent error readings of our digtail pin signal
for i = 0:10
    readDigitalPin(handles.rc.a,'D2')
    readDigitalPin(handles.rc.a,'D4')
end 
% graph work space
W = [-5 13.5 0 17.5 -5 5];
% each player is set a max life of 3.
player1= 3;
player2 = 3;
% this code will generate a random number up to 2 and call a file based on
% the vale returned by the if statement. 
random_file = randi(3);
 if random_file ==1
     answer_file = 'square.txt';
     ld = load('square.txt');
 elseif random_file ==2
     answer_file = 'triangle.txt';
     ld = load('Triangle.txt'); 
 else 
     answer_file = 'rectangle.txt';
     ld = load('Rectangle.txt');
 end 

 % once the file is loaded with the joint angles we set each of the columns
 % which is the joint angles per motor and the unmapped values to each
 % respective variable. 
handles.rc.x = ld(:,1);
handles.rc.y = ld(:,2);
handles.rc.x_pos = ld(:,3);
handles.rc.y_pos = ld(:,4);
% need to have z vector of values up to our joint columns. 
z = zeros(1,length(handles.rc.x)-1);

% outer for loop to iterate through each joint angle 
for i = 1:length(handles.rc.x) -1
    
    % this code is used so tpoly can draw out smoother lines between the
    % current angle and the angle to come by iterating through each step.
    [P1,SD1,SDD1] = tpoly(handles.rc.x(i), handles.rc.x(i+1),10);
    [P2,SD2,SDD2] = tpoly(handles.rc.y(i), handles.rc.y(i+1),10);
    for j = 1:length(P1)
        % the code below the if statement is to allow for each player to
        % guess, based on which pin is pressed that player will given a
        % choice to guess
        if ((readDigitalPin(handles.rc.a,'D2')) || (readDigitalPin(handles.rc.a,'D4')))
            if readDigitalPin(handles.rc.a,'D2') == 1
                prompt = 'Enter your guess(add .txt)';
                dlgtitle = 'Player 1 Guess';
                Player1_guess = inputdlg(prompt,dlgtitle);
                Player1_guess_str = char(Player1_guess);
                % compare the players guess with the file loaded use string
                % compare function to do this if they are right display
                % message and say they win.
                if strcmp(Player1_guess_str,answer_file)
                    msgbox('Player 1 wins')
                    pause(2)
                    return % code to end everything
                else
                    % Player is wrong so take away a life
                    player1 = player1 - 1;
                    disp('Player 2 lost a life')
                end
            end
            % player 2 pressed button so below else if runs
        elseif readDigitalPin(handles.rc.a,'D4') == 1
            prompt = 'Enter your guess(add .txt)';
            dlgtitle = 'Player 2 Guess';
            Player2_guess = inputdlg(prompt,dlgtitle);
            Player2_guess_str = char(Player2_guess);
            % if player 2 guess rights they win. 
            if strcmp(Player2_guess_str,answer_file)
                msgbox('Player 2 wins')
                pause(2)
                return % code to end everything
            else
                % player 2 guessed wrong so they loose a life. 
                player2 = player2 - 1;
                disp('Player 2 lost a life')
            end
            
        end
        % This code is to check if either player's lives are over then no
        % one wins the game.
        if player1 == 0 || player2 == 0
            msgbox('Game over no one wins')
            pause(2)
            return % code to stop the robot
        end
        % This code will actually move the hardware robot with each m step
        % in tpoly. 
        handles.rc.movePosition(handles.rc.s1,P1(j))
        handles.rc.movePosition(handles.rc.s2,P2(j))
    end
    % This code will plot the GUI robot based of each theta values unmapped.     
    handles.rc.robot.plot([-handles.rc.x_pos(i),-handles.rc.y_pos(i),z(i)], 'workspace', W);
    t = handles.rc.robot.fkine ([-handles.rc.x_pos(i), -handles.rc.y_pos(i), z(i)]);
    hold on;
    plot3(t.t(1), t.t(2), t.t(3), '--r.');
end

guidata(hObject, handles); 
