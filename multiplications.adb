--------------------------------------------------------------------------------
--  Auteur   : HAJJI MANAL
--  Objectif : Ecrire un programme qui révise la table de multiplication d'un entier.
--------------------------------------------------------------------------------

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Calendar;          use Ada.Calendar;
With Alea;

procedure Multiplications is
  
  package Mon_Alea is
      new Alea(1, 10); --générateur aléatoire de nombre de 1 à 10.
  use Mon_Alea;

  -- Déclaration des parametres.  
  n_table : Integer; --entier compris entre 1 et 10, entré par l'utilisateur.
  n_aleatoire : Integer; --nombre aléatoire généré par Alea.
  reponse : Integer; -- Réponse de l'utilisation à une multiplication donnée.
  n_erreurs : Integer; --nombre d'erreurs
  tempsmax : Duration; --temps maximal d'une réponse de la table.
  tempsmoyen : Duration; --temps moyen de toutes les réponses.
  debut : Time; --temps de début de question.
  fin : Time; -- temps de fin de réponse.
  duree_reponse : Duration; --le temps mis pour répondre à une multiplication donnée.
  n : Integer; --le nombre aléatoire dont l'utilisateur a mis un temps maximum pour répondre à sa multiplication.
  choix : Character; --choix de quitter ou continuer par l'utilisateur.

begin

    tempsmoyen := Duration(0);
    tempsmax := Duration(0);
    loop_1:
    loop
        n_erreurs := 0;
	loop_2:
	loop
	    -- Demander à l'utilisateur d'entrer un entier compris entre 1 et 10.
	    Put ("Entrer un entier compris entre 1 et 10 : ");
            Get (n_table);
	    -- Vérifier que l'utilisateur à entrer le bon entier.
	    if n_table < 1 then
		Put_Line("Erreur:l'entier que vous avez saisi est plus petit que 1.");
	    elsif n_table > 10 then
		Put_Line("Erreur:l'entier que vous avez saisi est plus grand que 1.");
	    else
		null;
	    end if;
	    exit loop_2 when 1 <= n_table and n_table <= 10;
        end loop loop_2;

	-- Réviser la table de multiplication de cet entier et commenter la performance de l'utilisateur selon le nombre de fautes et le temps mis.

	for i in 1..10 loop
	    -- Générer une multiplication avec un nombre aléatoire.
	    Get_Random_Number (n_aleatoire);
	    Put ("(M" & Integer'Image(i) & ")" & Integer'Image(n_table) & "*" & Integer'Image(n_aleatoire) & "?");
	    debut := Clock;
	    Get (reponse);
	    fin := Clock;
	    -- Vérifier la réponse de l'utilisateur.
	    if n_table * n_aleatoire = reponse then
		Put_Line("Bravo");
	    else
		Put_Line("Mauvaise réponse");
		n_erreurs := n_erreurs +1;
	    end if;
	    -- Calculer la durée de réponse de chaque multiplication.
	    duree_reponse := fin - debut;
	    tempsmoyen := tempsmoyen + duree_reponse / 10;
	    if duree_reponse > tempsmax then  -- Récuperer le nombre ou l'utilisateur a mis plus de temps pour répondre.
		tempsmax := duree_reponse;
		n := n_aleatoire;
	    else
		null;
	    end if;
	end loop;

        -- Commenter selon le nombre de fautes.
	Case n_erreurs is 
	    when 0 => Put_Line("Aucune Erreur. Excellent !");
	    when 1 => Put_Line("Une seule erreur,très bien");
	    when 10 => Put_Line("Tout est faux! Volontaire?");
	    when 6..9 => Put_Line("Seulement" & Integer'Image(10-n_erreurs) & "bonnes réponses.Il faut apprendre la table de"& Integer'Image(n_table));
            when others => Put_Line(Integer'Image(n_erreurs) & " erreurs.Il faut encore travailler la table de"& Integer'Image(n_table));
        end Case;

        -- Conseiller l'utilisateur de réviser la multiplication ou il a mis le  plus de temps.
	if tempsmax > (tempsmoyen + Duration(1)) then
	    Put_Line("Des hésitations sur la table de" & Integer'Image(n) & ":" & Duration'Image(tempsmax)& "secondes contre"& Duration'Image(tempsmoyen)&" en moyenne.Il faut certainement la réviser.");
	else 
	    null;
        end if;

	loop_3:
        loop
	    -- Demander à l'utilisateur s'il veut quitter ou continuer.
	    Put("on continue? (o/n)?  ");
	    Get(choix);
	    exit loop_3 when choix = 'n' or choix = 'N' or choix = 'o' or choix = 'O';
	end loop loop_3;
        	
	
	exit loop_1 when choix = 'n' or choix = 'N';
    end loop loop_1; 
end Multiplications;
