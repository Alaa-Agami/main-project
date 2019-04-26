function varargout = MainView(varargin)
% MAINVIEW MATLAB code for MainView.fig
%      MAINVIEW, by itself, creates a new MAINVIEW or raises the existing
%      singleton*.
%
%      H = MAINVIEW returns the handle to a new MAINVIEW or the handle to
%      the existing singleton*.
%
%      MAINVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINVIEW.M with the given input arguments.
%
%      MAINVIEW('Property','Value',...) creates a new MAINVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainView_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainView_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainView

% Last Modified by GUIDE v2.5 07-Feb-2019 21:43:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainView_OpeningFcn, ...
                   'gui_OutputFcn',  @MainView_OutputFcn, ...
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


% --- Executes just before MainView is made visible.
function MainView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainView (see VARARGIN)

% Choose default command line output for MainView
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainView wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('Images\Mainviewicon.PNG'));
javaFrame.setMaximized(true);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd Dataset
TT = [];
wt = waitbar(0,'Please Wait....');
for i = 1 : 500
    % I have chosen the name of each image in databases as a corresponding
    % number. However, it is not mandatory!
    str = int2str(i);
    str1 = strcat('ISIC_000000',str);
    str = strcat(str1,'.jpg');
    if exist(str, 'file')
		img = imread(str);
    [r c p] = size(img);
    if p==3
        img = rgb2gray(img);
    end
    img=imresize(img,[256 256]);
    [irow icol] = size(img);
    % % % % % 1 level decomp

    [LL LH HL HH] = dwt2(img,'db1');

    aa = [LL LH;HL HH];

    % % % % 2nd level decomp
    [LL1 LH1 HL1 HH1] = dwt2(LL,'db1');

    % aa1 = [LL1 LH1;HL1 HH1];

    % % % 3rd level Decomp

    [LL2 LH2 HL2 HH2] = dwt2(LL1,'db1');

    % % % 4th level Decomp

    [LL3 LH3 HL3 HH3] = dwt2(LL2,'db1');

      
    % % % Select the wavelet coefficients oly LH3 and HL3
    % % % GLCM features for LH3

    LH3 = uint8(LH3);
    Min_val = min(min(LH3));
    Max_val = max(max(LH3));
    level = round(Max_val - Min_val);
    GLCM = graycomatrix(LH3,'GrayLimits',[Min_val Max_val],'NumLevels',level);
    stat_feature = graycoprops(GLCM);
    Energy_fet1 = stat_feature.Energy;
    Contr_fet1 = stat_feature.Contrast;
    Corrla_fet1 = stat_feature.Correlation;
    Homogen_fet1 = stat_feature.Homogeneity;
    % % % % % Entropy
            R = sum(sum(GLCM));
            Norm_GLCM_region = GLCM/R;

            Ent_int = 0;
            for k = 1:length(GLCM)^2
                if Norm_GLCM_region(k)~=0
                    Ent_int = Ent_int + Norm_GLCM_region(k)*log2(Norm_GLCM_region(k));
                end
            end
    % % % % % % Ent_int = entropy(GLCM);
            Entropy_fet1 = -Ent_int;

    HL3 = uint8(HL3);
    Min_val = min(min(HL3));
    Max_val = max(max(HL3));
    level = round(Max_val - Min_val);
    GLCM = graycomatrix(HL3,'GrayLimits',[Min_val Max_val],'NumLevels',level);
    stat_feature = graycoprops(GLCM);
    Energy_fet2 = stat_feature.Energy;
    Contr_fet2 = stat_feature.Contrast;
    Corrla_fet2= stat_feature.Correlation;
    Homogen_fet2 = stat_feature.Homogeneity;
    % % % % % Entropy
            R = sum(sum(GLCM));
            Norm_GLCM_region = GLCM/R;

            Ent_int = 0;
            for k = 1:length(GLCM)^2
                if Norm_GLCM_region(k)~=0
                    Ent_int = Ent_int + Norm_GLCM_region(k)*log2(Norm_GLCM_region(k));
                end
            end
    % % % % % % Ent_int = entropy(GLCM);
            Entropy_fet2 = -Ent_int;
            F1 = [Energy_fet1 Contr_fet1 Corrla_fet1 Homogen_fet1 Entropy_fet1];
            F2 = [Energy_fet2 Contr_fet2 Corrla_fet2 Homogen_fet2 Entropy_fet2];
            Fet = [F1 F2]';
     TT = [TT Fet]; 
     waitbar(i/10,wt);
    else	
	end  
 end
close(wt);
Database_feature=TT;
cd ..                                                                                             
handles.Dfeature = Database_feature;
[Fr,Fs, Lr, Ls] = Pts(Database_feature); 
K               = 8;                               
KMI             = 10;                             
[W, MU, SIGMA]  = rbfn_train(Fr, Lr, K, KMI);
handles.K  = K;
handles.Ls = Ls;
handles.Fs = Fs;
handles.W  =W;
handles.MU  =MU;
handles.SIGMA  =SIGMA;
helpdlg('Trainined sucessfully');
guidata(hObject,handles);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd Dataset
[fn, pn]=uigetfile('*.jpg;*.bmp;*.tif;*.gif;*.png','Pick an Image File');
cd ..
I= imread([pn,fn]);
handles.I  = I;
imshow(I,'parent',handles.axes1);
title('\fontsize{12} \bf Original Image','FontName','Cambria','color','r','parent',handles.axes1);
handles.fname=fn;
handles.path = pn;
I=imresize(I,[250 350]);
imwrite(I,'Process_Image\Original.jpg','jpg');
imwrite(I,'Process_Image\input.tif','tif');
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im=imread('Process_Image\input.tif');
myred=im(:,:,1);
mygreen=im(:,:,2);
myblue=im(:,:,3);
% cat- concatenates the arrays
MyRGB = cat(3,myred,mygreen,myblue); 
MyGray = rgb2gray(MyRGB);
MyGray = 0.2989*MyRGB(:,:,1) + 0.5870*MyRGB(:,:,2) + 0.1140*MyRGB(:,:,3);
imshow(MyGray);
title('\fontsize{12} \bf Grayscale Image','FontName','Cambria','color','r');
S=imresize(MyGray,[250 350]);
imwrite(S,'Process_Image\input1.tif','tif');
H = fspecial('gaussian',3,0.5);
MotionBlur = imfilter(MyGray,H,'replicate');
figure,imshow(MotionBlur)
bw = otsu1(MotionBlur);
figure,imshow(bw);
lay(MotionBlur);
I =  handles.I;  %-- load the image
I1 =  handles.I; 
I=rgb2gray(I);
m = zeros(size(I,1),size(I,2));          %-- create initial mask
m(200:322,250:384) = 1;
I = imresize(I,.5);  %-- make image smaller 
m = imresize(m,.5);  %     for fast computation
%figure,subplot(2,2,1); imshow(I); title('Input Image');
% subplot(2,2,2); imshow(m); title('Initialization');
%subplot(2,2,2); title('Segmentation');
se = seg(I, m, 250); %-- Run segmentation
seg1(I1);
subplot(2,2,3); imshow(se); title(' regions in the skin lesion image');
imwrite(se,'Process_Image\test.tif','tif');
[a,b,c,d,e,f,g,h,i1]=FeaturesSelection('Process_Image\input.tif');
a1 = sprintf('D_Area of the image (D).... %d \n',a);
disp(a1);
b1 = sprintf('Maximum Intensity of the image (D).... %d \n',b);
disp(b1);
c1 = sprintf('Minimum Intensity of the image (D).... %d \n',c);
disp(c1);
d1 = sprintf('Mean Intensity of the image (D).... %f',d);
disp(d1);
e1 = sprintf('diameters of the image (D).... %f ',e);
disp(e1);
f1 = sprintf('Circularity of the image (A).... %f ',f);
disp(f1);
g1 = sprintf('Aspect Ratio of the image (AR).... %f ',g);
disp(g1);
h1 = sprintf('Sharpness of the image.... %f ',h);
disp(h1);
i2 = sprintf('Entropy of the image.... %f\n ',i1);
disp(i2);
guidata(hObject, handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I =  imread('Process_Image\Original.jpg');
%% get edge map
% Canny edge detector is used here. Other edge detectors can also be used
eth=0.1; % thershold for canny edge detector
edgeMap=edge(rgb2gray(I),'canny',eth,1);
figure,imshow(edgeMap);
title('\fontsize{12} \bf Edge Map','FontName','Cambria','color','r');
cd('required/mex');
mex FAST_STDFILT_mex.c
mex REMAP2REFOCUS_mex.c
cd('..');
cd('..');
% file path
I1=imresize(edgeMap,[3280 3280]);
imwrite(I1,'Process_Image\depimg.jpg','jpg');
file_path     =  'Process_Image\depimg.jpg';                                ;
% the main function for kernel map for CNN
depth_output  = compute_LFdepth(file_path); 
huhaan_tim(I);
res = elderzucker_tim(I);
handles.rec=res;
guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K;
K = handles.K;
Fs = handles.Fs;
W = handles.W;
MU = handles.MU;
Ls = handles.Ls;
SIGMA = handles.SIGMA;
f =  handles.fname ;
cd Dataset
TT = [];
wt = waitbar(0,'Please Wait....');
for i = 1 : 10
    % I have chosen the name of each image in databases as a corresponding
    % number. However, it is not mandatory!
    str = int2str(i);
    str1 = strcat('ISIC_000000',str);
    str = strcat(str1,'.jpg');
    if exist(str, 'file')
		img = imread(str);
    [r c p] = size(img);
    if p==3
        img = rgb2gray(img);
    end
    img=imresize(img,[256 256]);
    [irow icol] = size(img);
    % % % % % 1 level decomp

    [LL LH HL HH] = dwt2(img,'db1');

    aa = [LL LH;HL HH];

    % % % % 2nd level decomp
    [LL1 LH1 HL1 HH1] = dwt2(LL,'db1');

    % aa1 = [LL1 LH1;HL1 HH1];

    % % % 3rd level Decomp

    [LL2 LH2 HL2 HH2] = dwt2(LL1,'db1');

    % % % 4th level Decomp

    [LL3 LH3 HL3 HH3] = dwt2(LL2,'db1');

      
    % % % Select the wavelet coefficients oly LH3 and HL3
    % % % GLCM features for LH3

    LH3 = uint8(LH3);
    Min_val = min(min(LH3));
    Max_val = max(max(LH3));
    level = round(Max_val - Min_val);
    GLCM = graycomatrix(LH3,'GrayLimits',[Min_val Max_val],'NumLevels',level);
    stat_feature = graycoprops(GLCM);
    Energy_fet1 = stat_feature.Energy;
    Contr_fet1 = stat_feature.Contrast;
    Corrla_fet1 = stat_feature.Correlation;
    Homogen_fet1 = stat_feature.Homogeneity;
    % % % % % Entropy
            R = sum(sum(GLCM));
            Norm_GLCM_region = GLCM/R;

            Ent_int = 0;
            for k = 1:length(GLCM)^2
                if Norm_GLCM_region(k)~=0
                    Ent_int = Ent_int + Norm_GLCM_region(k)*log2(Norm_GLCM_region(k));
                end
            end
    % % % % % % Ent_int = entropy(GLCM);
            Entropy_fet1 = -Ent_int;

    HL3 = uint8(HL3);
    Min_val = min(min(HL3));
    Max_val = max(max(HL3));
    level = round(Max_val - Min_val);
    GLCM = graycomatrix(HL3,'GrayLimits',[Min_val Max_val],'NumLevels',level);
    stat_feature = graycoprops(GLCM);
    Energy_fet2 = stat_feature.Energy;
    Contr_fet2 = stat_feature.Contrast;
    Corrla_fet2= stat_feature.Correlation;
    Homogen_fet2 = stat_feature.Homogeneity;
    % % % % % Entropy
            R = sum(sum(GLCM));
            Norm_GLCM_region = GLCM/R;

            Ent_int = 0;
            for k = 1:length(GLCM)^2
                if Norm_GLCM_region(k)~=0
                    Ent_int = Ent_int + Norm_GLCM_region(k)*log2(Norm_GLCM_region(k));
                end
            end
    % % % % % % Ent_int = entropy(GLCM);
            Entropy_fet2 = -Ent_int;
            F1 = [Energy_fet1 Contr_fet1 Corrla_fet1 Homogen_fet1 Entropy_fet1];
            F2 = [Energy_fet2 Contr_fet2 Corrla_fet2 Homogen_fet2 Entropy_fet2];
            Fet = [F1 F2]';
     TT = [TT Fet]; 
     waitbar(i/10,wt);
    else	
	end  
 end
close(wt);
Database_feature=TT;
cd ..                                                                                             
handles.Dfeature = Database_feature;
%Y    = rbfn_test(Fs, W, K, MU, SIGMA);
Y    = ReLu(Fs, W, K, MU, SIGMA);
SR   = 1 - sum(abs(Y-Ls))/size(Y,1);
output_args=clasfic(f,SR);
   

%disp(output_args);
handles.resultnew=output_args;
set(handles.edit1,'string',output_args);
guidata(hObject, handles);
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Text            = handles.resultnew;
Message         = int32(Text);

fprintf('-Input-\n')
fprintf('Original message:       ''%s''\n', Text)
fprintf('Integer representation: %s\n', num2str(Message))

%% Generate Key Pair

[handles.Modulus, PublicExponent, handles.PrivateExponent] = GenerateKeyPair;

fprintf('\n-Key Pair-\n')
fprintf('Modulus:                '), fprintf('%5d\n', handles.Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', handles.PrivateExponent)

%% Encrypt / Decrypt

handles.Ciphertext      = Encrypt(handles.Modulus, PublicExponent, Message);
mymsg = num2str(handles.Ciphertext);
disp(num2str(handles.Ciphertext));
helpdlg(num2str(handles.Ciphertext),'Encryption Completed') ;
fid = fopen('exp.txt','w');
        fprintf(fid,mymsg);
        fclose(fid);
pause(3);
guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RestoredMessage	= Decrypt(handles.Modulus, handles.PrivateExponent, handles.Ciphertext);

%fprintf('\n-Encryption-\n')
%fprintf('Ciphertext:             %s [ %s ]\n', num2str(Ciphertext), char(Ciphertext))
fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))
helpdlg(char(RestoredMessage),'Decryption Completed');
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
loc='exp.txt';
send_mail_message('divyasreekanth7','CipherText','Please Decrypt the attached CipherText to view the Analysis Result',loc);
