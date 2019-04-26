function [ output_args ] = rsaencrypt( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Text            = input_args;
Message         = int32(Text);

fprintf('-Input-\n')
fprintf('Original message:       ''%s''\n', Text)
fprintf('Integer representation: %s\n', num2str(Message))

%% Generate Key Pair

[Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair;

fprintf('\n-Key Pair-\n')
fprintf('Modulus:                '), fprintf('%5d\n', Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', PrivateExponent)

%% Encrypt / Decrypt

Ciphertext      = Encrypt(Modulus, PublicExponent, Message);
%fprintf('\n-Encryption-\n')
%fprintf('Ciphertext:             %s [ %s ]\n', num2str(Ciphertext), char(Ciphertext))
 helpdlg('Encryption Completed') ;
 output_args=(Ciphertext);
end

