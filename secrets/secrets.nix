# Secrets configuration file used by the agenix cli tool
# https://github.com/ryantm/agenix

let

    # add the (publickeys of the) users which should be able to decrypt the secret
    secretsManager = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6ukDjj3NFbBAGK6xRQ+q8qJvTJiCMFY8HiKsOrbRxs rob-essentialit-secrets";
    users = [ secretsManager ];

    # add the (publickeys of the) machines you want to deploy to here
    l241214a = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYJl558EaOyqvji1JT2m5m0JyCnHR9HmPt3zsp9Phqx root@l241214a";
    systems = [ l241214a ];
in
{
  "litellm.age".publicKeys = [ secretsManager  l241214a ];
  #"secret2.age".publicKeys = users ++ systems;
  "armored-secret.age" = {
    publicKeys = [ secretsManager ];
    armor = true;
  };
}