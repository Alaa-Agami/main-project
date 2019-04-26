function [ output_args ] = rsadecrypt( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Ciphertext = input_args;
[Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair;

fprintf('\n-Key Pair-\n')
fprintf('Modulus:                '), fprintf('%5d\n', Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', PrivateExponent)

RestoredMessage	= Decrypt(Modulus, PrivateExponent, Ciphertext);
fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))
output_args = char(RestoredMessage);

end

