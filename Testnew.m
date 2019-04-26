
Text            = 'common mole';
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
RestoredMessage	= Decrypt(Modulus, PrivateExponent, Ciphertext);

fprintf('\n-Encryption-\n')
fprintf('Ciphertext:             %s [ %s ]\n', num2str(Ciphertext), char(Ciphertext))
fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))

%% Sign / Validate

Signature       = Sign(Modulus, PrivateExponent, Message);
IsVerified      = Verify(Modulus, PublicExponent, Message, Signature);

fprintf('\n-Signing-\n')
fprintf('Signature:              %s [ %s ]\n', num2str(Signature), char(Signature))
fprintf('Is Verified:            %d\n', IsVerified)