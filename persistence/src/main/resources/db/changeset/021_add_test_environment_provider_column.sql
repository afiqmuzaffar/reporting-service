ALTER TABLE launcher_presets ADD COLUMN provider_id INT NULL;
ALTER TABLE launcher_presets ADD CONSTRAINT fk_LAUNCHER_PRESET_INTEGRATIONS1
    FOREIGN KEY (provider_id)
        REFERENCES INTEGRATIONS (id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION;

DO
$$
    DECLARE
        PROVIDER_ID_VAR INTEGRATIONS.id%TYPE;
        LAUNCHER_PRESET_ID_VAR LAUNCHER_PRESETS.id%TYPE;

    BEGIN

        PROVIDER_ID_VAR := (SELECT ID FROM INTEGRATIONS WHERE NAME = 'ZEBRUNNER');

        FOR LAUNCHER_PRESET_ID_VAR IN SELECT ID FROM LAUNCHER_PRESETS
            LOOP
                UPDATE LAUNCHER_PRESETS SET provider_id = PROVIDER_ID_VAR WHERE ID = LAUNCHER_PRESET_ID_VAR;
            END LOOP;

    END
$$;