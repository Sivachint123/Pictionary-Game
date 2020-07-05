classdef Robot_class
        properties
            % These are all the variables of the robot class, this is what
            % will be used in the handles structure of the GUI to
            % manipulate data around with the functions of this class. 
            robot;
            theta; 
            x;
            y;
            s1;
            s2;
            s3;
            a;
            b;
            x_pos;
            y_pos;
            
        end
        methods
            function obj = Robot_class()
                % This function is called the default constructor it is
                % used to intialize all of the properties of the
                % Robot_class, the purpose of this is that if values are
                % not intialized then there will be some arbitrary values
                % stored in each variable which can cause the program to
                % misbehave. 
                obj.x = [];
                obj.y = [];
                obj.s1 = 1;
                obj.s2 = 1;
                obj.s3 = 1;
                obj.a = [];
                obj.b = [];
                obj.theta = [0 0 0];
                obj.robot = [];
                obj.x_pos = [];
                obj.y_pos = [];
            end
       
            
            function y = map_fn(obj, theta, min, max)
                % This function is to standardize the theta values with
                % values between 0 and 1 so movePosition can use them as an
                % argument in there parameters. 
                
                y = (theta - min)./(max - min);
                
            end
            
            function movePosition(obj, joint,temp)
            % The function will move the robot based on which joint
            % selected and which value (temp) used. the obj is treated as a
            % pointer to the object of Robot_class
               writePosition(joint,temp)
               
            end
            
            function temp = getPosition(obj, joint)
                %This function will get the actual values of the hardware
                % movement of the robot.
                temp = readPosition(joint);
            end             
            
        end
end

  
