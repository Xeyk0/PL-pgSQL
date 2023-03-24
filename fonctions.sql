CREATE OR REPLACE FUNCTION calculer_longueur_max(str1 char, str2 char)
RETURNS INTEGER AS $$
DECLARE
    longueur1 INTEGER;
    longueur2 INTEGER;
BEGIN
    longueur1 := length(str1);
    longueur2 := length(str2);

    IF longueur1 > longueur2 THEN
        RETURN longueur1;
    ELSE
        RETURN longueur2;
    END IF;
END;
$$ LANGUAGE plpgsql;




--1ere version de la fonction nb_occurrence en utilisant une boucle FOR--

CREATE OR REPLACE FUNCTION nb_occurrence(str char, 
  pos_debut integer, 
  pos_fin integer, 
  char_cible character
) RETURNS integer AS $$
DECLARE
  count integer := 0;
BEGIN
  IF pos_debut < 1 THEN
    RAISE EXCEPTION 'La position de départ doit être supérieure à 0';
  END IF;
  IF pos_fin > length(str) THEN
    RAISE EXCEPTION 'La position de fin doit être inférieure ou égale à la longueur de la chaîne';
  END IF;
  IF pos_fin < pos_debut THEN
    RAISE EXCEPTION 'La position de fin doit être supérieure ou égale à la position de départ';
  END IF;

  FOR i IN pos_debut..pos_fin LOOP
    IF substring(str from i for 1) = char_cible THEN
      count := count + 1;
    END IF;
  END LOOP;
  
  RETURN count;
END;
$$ LANGUAGE plpgsql;


/*
--2ème version de la fonction nb_occurrence en utilisant une boucle WHILE--

CREATE OR REPLACE FUNCTION nb_occurrence(str char, 
  pos_debut integer, 
  pos_fin integer, 
  char_cible character
) RETURNS integer AS $$
DECLARE
  count integer := 0;
  i integer := pos_debut;
  curr_char character;
BEGIN
  IF pos_debut < 1 THEN
    RAISE EXCEPTION 'La position de départ doit être supérieure à 0';
  END IF;
  IF pos_fin > length(str) THEN
    RAISE EXCEPTION 'La position de fin doit être inférieure ou égale à la longueur de la chaîne';
  END IF;
  IF pos_fin < pos_debut THEN
    RAISE EXCEPTION 'La position de fin doit être supérieure ou égale à la position de départ';
  END IF;

  WHILE i <= pos_fin LOOP
    curr_char := substring(str from i for 1);
    IF curr_char = char_cible THEN
      count := count + 1;
    END IF;
    i := i + 1;
  END LOOP;
  RETURN count;
END;
$$ LANGUAGE plpgsql;

--13ere version de la fonction nb_occurrence en utilisant une boucle LOOP/EXIT--

CREATE OR REPLACE FUNCTION nb_occurrence(str char, 
  pos_debut integer, 
  pos_fin integer, 
  char_cible character
) RETURNS integer AS $$
DECLARE
  count integer := 0;
  i integer := pos_debut;
  curr_char character;
BEGIN
  IF pos_debut < 1 THEN
    RAISE EXCEPTION 'La position de départ doit être supérieure à 0';
  END IF;
  IF pos_fin > length(str) THEN
    RAISE EXCEPTION 'La position de fin doit être inférieure ou égale à la longueur de la chaîne';
  END IF;
  IF pos_fin < pos_debut THEN
    RAISE EXCEPTION 'La position de fin doit être supérieure ou égale à la position de départ';
  END IF;

  LOOP
    EXIT WHEN i > pos_fin;
    curr_char := substring(str from i for 1);
    IF curr_char = char_cible THEN
      count := count + 1;
    END IF;
    i := i + 1;
  END LOOP;
  RETURN count;
END;
$$ LANGUAGE plpgsql;

*/

CREATE OR REPLACE FUNCTION getNbJoursParMois(date_saisie date) RETURNS integer AS $$
DECLARE
  annee integer := extract(year from date_saisie);
  mois integer := extract(month from date_saisie);
  debut_mois date := to_date(concat(annee, '-', mois, '-01'), 'YYYY-MM-DD');
  fin_mois date := debut_mois + interval '1 month - 1 day';
BEGIN
  RETURN extract(day from fin_mois);
END;
$$ LANGUAGE plpgsql;



