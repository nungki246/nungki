CREATE OR REPLACE FUNCTION public.update_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
	NEW.update_at = now();
    RETURN NEW;   
END;
$function$
;
