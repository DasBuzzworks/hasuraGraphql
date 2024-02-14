SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;

CREATE TABLE public.designation (
    id uuid NOT NULL,
    name text,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.designation IS 'This table is for storing designations ';
CREATE TABLE public.lead (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text,
    mobile_number text,
    country_code text,
    lead_status text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.lead IS 'This is for storing leads when a user signs up for the first time before creating their workspace';
CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text,
    email text,
    username text,
    mobile_number text,
    country_code text,
    password text,
    email_verification_status text DEFAULT 'PENDING'::text NOT NULL,
    verification_status text DEFAULT 'PENDING'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    cognito_id text
);
COMMENT ON TABLE public.users IS 'This table is for storing users';
CREATE TABLE public.workspaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text,
    email text,
    mobile_number text,
    country_code text,
    workspace_url text,
    lead_id uuid,
    owner_id uuid,
    owner_name text,
    industry text,
    size text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    organization_name text,
    owner_cognito_id text
);
COMMENT ON TABLE public.workspaces IS 'For storing workspace for users';
ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_email_key UNIQUE (email);
ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_email_key UNIQUE (email);
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_designation_updated_at BEFORE UPDATE ON public.designation FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_designation_updated_at ON public.designation IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_lead_updated_at BEFORE UPDATE ON public.lead FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_lead_updated_at ON public.lead IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_user_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_user_updated_at ON public.users IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_workspace_updated_at BEFORE UPDATE ON public.workspaces FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_workspace_updated_at ON public.workspaces IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.lead(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
