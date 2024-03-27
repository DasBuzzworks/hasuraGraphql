SET check_function_bodies = false;
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
CREATE TABLE public.address_master_onboarding (
    id integer NOT NULL,
    employee_id integer,
    permanent_address_line1 character varying(255),
    permanent_address_line2 character varying(255),
    permanent_address_country character varying(255),
    permanent_address_city character varying(255),
    permanent_address_state character varying(255),
    permanent_address_pincode integer,
    current_address_line1 character varying(255),
    current_address_line2 character varying(255),
    current_address_country character varying(255),
    current_address_city character varying(255),
    current_address_state character varying(255),
    current_address_pincode integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.address_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.address_master_onboarding_id_seq OWNED BY public.address_master_onboarding.id;
CREATE TABLE public.cities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    state_id uuid NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.cities IS 'This table is for storing cities';
CREATE TABLE public.corporations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
CREATE TABLE public.countries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    country_code text NOT NULL,
    phone_country_code text NOT NULL,
    currency_code text NOT NULL,
    currency_name name NOT NULL,
    region_id uuid NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone,
    status boolean DEFAULT true NOT NULL
);
CREATE TABLE public.department_master (
    department_id integer NOT NULL,
    name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.department_master_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.department_master_department_id_seq OWNED BY public.department_master.department_id;
CREATE TABLE public.designation (
    id integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.designation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.designation_id_seq OWNED BY public.designation.id;
CREATE TABLE public.designation_master (
    designation_id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.designation_master_designation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.designation_master_designation_id_seq OWNED BY public.designation_master.designation_id;
CREATE TABLE public.designations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status boolean NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at uuid,
    customer_id uuid NOT NULL
);
CREATE TABLE public.districts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    state_id uuid NOT NULL,
    status boolean NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
CREATE TABLE public.education_details_onboarding (
    id integer NOT NULL,
    employee_id integer,
    school_name character varying(255),
    education_type_id integer,
    year_of_passing character varying(255),
    percentage_or_cgpa character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.education_details_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.education_details_onboarding_id_seq OWNED BY public.education_details_onboarding.id;
CREATE TABLE public.emergency_contact_master_onboarding (
    id integer NOT NULL,
    employee_id integer,
    emergency_contact_number character varying(255),
    emergency_contact_person character varying(255),
    emergency_contact_person_relation character varying(255),
    emergency_contact_person_email character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.emergency_contact_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.emergency_contact_master_onboarding_id_seq OWNED BY public.emergency_contact_master_onboarding.id;
CREATE TABLE public.employee (
    employee_id integer NOT NULL,
    employee_type_id integer,
    user_id character varying(255),
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    contact_number character varying(255),
    short_description character varying(255),
    hobbies_and_interests character varying(255),
    date_of_birth character varying(255),
    personal_email character varying(255),
    work_email character varying(255),
    blood_group character varying(255),
    legal_entity character varying(255),
    employment_type character varying(255),
    employee_code character varying(255),
    joining_date timestamp with time zone,
    designation_id integer,
    reporting_to character varying(255),
    department_id integer,
    location character varying(255),
    business_unit character varying(255),
    time_type character varying(255),
    shift character varying(255),
    weekly_off character varying(255),
    leave_policy character varying(255),
    holiday_plan character varying(255),
    pay_group character varying(255),
    salary_structure character varying(255),
    annual_salary integer,
    effective_date timestamp with time zone,
    tax_regime character varying(255),
    bonus_type character varying(255),
    bonus_amount integer,
    bonus_due_date timestamp with time zone,
    eligible_for_pf boolean,
    eligible_for_esi boolean,
    eligible_for_lwf boolean,
    status character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.employee_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.employee_employee_id_seq OWNED BY public.employee.employee_id;
CREATE TABLE public.employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name text NOT NULL,
    middle_name text,
    laste_name text NOT NULL,
    contact_number text NOT NULL,
    short_description text NOT NULL,
    hobbies_and_interests text,
    date_of_birth text NOT NULL,
    personal_email text NOT NULL,
    work_email text NOT NULL,
    blood_group text NOT NULL,
    employee_code text NOT NULL,
    joining_date text NOT NULL,
    workoing_shift_type text NOT NULL,
    working_shift_hours text NOT NULL,
    weekly_offs text NOT NULL,
    leave_policy text NOT NULL,
    holiday_plan text NOT NULL,
    pay_group text NOT NULL,
    salary_structure text NOT NULL,
    annual_salary text NOT NULL,
    effective_date date NOT NULL,
    tax_regime text NOT NULL,
    bonus_type text NOT NULL,
    bonus_amount text NOT NULL,
    bonus_due_date date NOT NULL,
    source_of_hire text NOT NULL,
    confirmed_doj date NOT NULL,
    recruited_by name NOT NULL,
    legal_entity_id uuid NOT NULL,
    sub_entity_id uuid NOT NULL,
    designation_id uuid NOT NULL,
    loation_id uuid,
    department_id uuid NOT NULL,
    reporting_to_id uuid NOT NULL,
    employment_type_id uuid NOT NULL,
    user_id uuid NOT NULL,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.employees IS 'This table is for storing all the empoyees';
CREATE TABLE public.employment_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status boolean NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.employment_types IS 'This table is for storing employment types';
CREATE TABLE public.form_metadata (
    type text NOT NULL,
    form_fields json NOT NULL
);
COMMENT ON TABLE public.form_metadata IS 'This table is for storing form fields ';
CREATE TABLE public.form_type (
    value text NOT NULL
);
COMMENT ON TABLE public.form_type IS 'This is for storing form types';
CREATE TABLE public.industries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text NOT NULL,
    status boolean NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.industries IS 'This table falls under ''global'' and is for storing all industris';
CREATE TABLE public.kyc_master_onboarding (
    id integer NOT NULL,
    aadhar_number character varying(255),
    name_as_in_aadhar character varying(255),
    dob_as_in_aadhar character varying(255),
    enrollment_number character varying(255),
    gender character varying(255),
    address character varying(255),
    "fatherName_as_in_aadhar" character varying(255),
    "spouseName_as_in_aadhar" character varying(255),
    bank_account_number character varying(255),
    account_holder_name character varying(255),
    bank_ifsc_code character varying(255),
    bank_name character varying(255),
    bank_branch character varying(255),
    pan_number character varying(255),
    name_as_in_pan character varying(255),
    "fatherName_as_in_pan" character varying(255),
    pan_verified character varying(255),
    aadhar_verified character varying(255),
    bank_verified character varying(255),
    verified_by character varying(255),
    employee_id integer,
    customer_id character varying(255),
    uan_number character varying(255),
    document_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.kyc_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.kyc_master_onboarding_id_seq OWNED BY public.kyc_master_onboarding.id;
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
CREATE TABLE public.legal_entities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_id uuid NOT NULL,
    name name NOT NULL,
    description text,
    mobile_numbr text NOT NULL,
    alternate_mobile_number text NOT NULL,
    email_address text NOT NULL,
    sector text NOT NULL,
    date_of_encorporation date NOT NULL,
    poc_name name NOT NULL,
    registered_address text NOT NULL,
    corporate_address text NOT NULL,
    billing_address text NOT NULL,
    shipping_address text NOT NULL,
    pan text NOT NULL,
    gst text NOT NULL,
    tan text NOT NULL,
    industry text NOT NULL,
    company_size text NOT NULL,
    website text NOT NULL,
    act_applicable text NOT NULL,
    relationship_start_date date NOT NULL,
    relationship_end_date date NOT NULL,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.legal_entities IS 'This table is for storing legal_entitites';
CREATE TABLE public.nominee_master_onboarding (
    id integer NOT NULL,
    name character varying(255),
    aadhar_number character varying(255),
    dob character varying(255),
    relation character varying(255),
    phone_number character varying(255),
    employee_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.nominee_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.nominee_master_onboarding_id_seq OWNED BY public.nominee_master_onboarding.id;
CREATE TABLE public.previous_employer_master_onboarding (
    id integer NOT NULL,
    employer_id character varying(255),
    employer_name character varying(255),
    date_of_joining timestamp with time zone,
    date_of_releiving timestamp with time zone,
    location character varying(255),
    reason_for_changing character varying(255),
    employee_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.previous_employer_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.previous_employer_master_onboarding_id_seq OWNED BY public.previous_employer_master_onboarding.id;
CREATE TABLE public.regions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.regions IS 'This table is for storing all the regions';
CREATE TABLE public.saas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
CREATE TABLE public.states (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now(),
    deleted_by uuid,
    deleted_at timestamp with time zone,
    country_id uuid,
    ut_id text,
    ut_name name
);
COMMENT ON TABLE public.states IS 'This table falls under ''global'' and is for storing all districts';
CREATE TABLE public.sub_entities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name name NOT NULL,
    description text,
    legal_entity_id uuid NOT NULL,
    type text NOT NULL,
    status boolean DEFAULT true NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_by uuid,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_by uuid,
    deleted_at timestamp with time zone
);
COMMENT ON TABLE public.sub_entities IS 'This table is for storing sub_entitites';
CREATE TABLE public.task_master_onboarding (
    id integer NOT NULL,
    task_group character varying(255),
    task_name character varying(255),
    description character varying(255),
    due_date timestamp with time zone,
    screen_name character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
CREATE SEQUENCE public.task_master_onboarding_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.task_master_onboarding_id_seq OWNED BY public.task_master_onboarding.id;
CREATE TABLE public.user_documents_metadatas (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
COMMENT ON TABLE public.user_documents_metadatas IS 'This is for storing employee do';
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
    cognito_id text,
    email_verification_token text
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
ALTER TABLE ONLY public.address_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.address_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.department_master ALTER COLUMN department_id SET DEFAULT nextval('public.department_master_department_id_seq'::regclass);
ALTER TABLE ONLY public.designation ALTER COLUMN id SET DEFAULT nextval('public.designation_id_seq'::regclass);
ALTER TABLE ONLY public.designation_master ALTER COLUMN designation_id SET DEFAULT nextval('public.designation_master_designation_id_seq'::regclass);
ALTER TABLE ONLY public.education_details_onboarding ALTER COLUMN id SET DEFAULT nextval('public.education_details_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.emergency_contact_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.emergency_contact_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.employee ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_employee_id_seq'::regclass);
ALTER TABLE ONLY public.kyc_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.kyc_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.nominee_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.nominee_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.previous_employer_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.previous_employer_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.task_master_onboarding ALTER COLUMN id SET DEFAULT nextval('public.task_master_onboarding_id_seq'::regclass);
ALTER TABLE ONLY public.address_master_onboarding
    ADD CONSTRAINT address_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.corporations
    ADD CONSTRAINT corporations_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.department_master
    ADD CONSTRAINT department_master_pkey PRIMARY KEY (department_id);
ALTER TABLE ONLY public.designation_master
    ADD CONSTRAINT designation_master_pkey PRIMARY KEY (designation_id);
ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.designations
    ADD CONSTRAINT designations_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.education_details_onboarding
    ADD CONSTRAINT education_details_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.emergency_contact_master_onboarding
    ADD CONSTRAINT emergency_contact_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.employment_types
    ADD CONSTRAINT employment_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.form_type
    ADD CONSTRAINT form_type_pkey PRIMARY KEY (value);
ALTER TABLE ONLY public.form_metadata
    ADD CONSTRAINT forms_metadata_pkey PRIMARY KEY (type);
ALTER TABLE ONLY public.kyc_master_onboarding
    ADD CONSTRAINT kyc_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_email_key UNIQUE (email);
ALTER TABLE ONLY public.lead
    ADD CONSTRAINT lead_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.legal_entities
    ADD CONSTRAINT legal_entitites_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.industries
    ADD CONSTRAINT master_industries_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.nominee_master_onboarding
    ADD CONSTRAINT nominee_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.previous_employer_master_onboarding
    ADD CONSTRAINT previous_employer_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.saas
    ADD CONSTRAINT saas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.sub_entities
    ADD CONSTRAINT sub_entities_name_key UNIQUE (name);
ALTER TABLE ONLY public.sub_entities
    ADD CONSTRAINT sub_entities_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.task_master_onboarding
    ADD CONSTRAINT task_master_onboarding_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_documents_metadatas
    ADD CONSTRAINT user_documents_metadatas_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_email_key UNIQUE (email);
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_pkey PRIMARY KEY (id);
CREATE TRIGGER set_public_cities_updated_at BEFORE UPDATE ON public.cities FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_cities_updated_at ON public.cities IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_corporations_updated_at BEFORE UPDATE ON public.corporations FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_corporations_updated_at ON public.corporations IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_countries_updated_at BEFORE UPDATE ON public.countries FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_countries_updated_at ON public.countries IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_designations_updated_at BEFORE UPDATE ON public.designations FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_designations_updated_at ON public.designations IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_districts_updated_at BEFORE UPDATE ON public.districts FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_districts_updated_at ON public.districts IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_employees_updated_at BEFORE UPDATE ON public.employees FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_employees_updated_at ON public.employees IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_employment_types_updated_at BEFORE UPDATE ON public.employment_types FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_employment_types_updated_at ON public.employment_types IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_industries_updated_at BEFORE UPDATE ON public.industries FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_industries_updated_at ON public.industries IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_lead_updated_at BEFORE UPDATE ON public.lead FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_lead_updated_at ON public.lead IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_legal_entitites_updated_at BEFORE UPDATE ON public.legal_entities FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_legal_entitites_updated_at ON public.legal_entities IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_master_districts_updated_at BEFORE UPDATE ON public.states FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_master_districts_updated_at ON public.states IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_master_industries_updated_at BEFORE UPDATE ON public.industries FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_master_industries_updated_at ON public.industries IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_regions_updated_at BEFORE UPDATE ON public.regions FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_regions_updated_at ON public.regions IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_saas_updated_at BEFORE UPDATE ON public.saas FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_saas_updated_at ON public.saas IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_states_updated_at BEFORE UPDATE ON public.states FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_states_updated_at ON public.states IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_sub_entities_updated_at BEFORE UPDATE ON public.sub_entities FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_sub_entities_updated_at ON public.sub_entities IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_user_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_user_updated_at ON public.users IS 'trigger to set value of column "updated_at" to current timestamp on row update';
CREATE TRIGGER set_public_workspace_updated_at BEFORE UPDATE ON public.workspaces FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_workspace_updated_at ON public.workspaces IS 'trigger to set value of column "updated_at" to current timestamp on row update';
ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.states(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_designation_id_fkey FOREIGN KEY (designation_id) REFERENCES public.designations(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_employment_type_id_fkey FOREIGN KEY (employment_type_id) REFERENCES public.employment_types(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_legal_entity_id_fkey FOREIGN KEY (legal_entity_id) REFERENCES public.legal_entities(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_sub_entity_id_fkey FOREIGN KEY (sub_entity_id) REFERENCES public.sub_entities(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.form_metadata
    ADD CONSTRAINT form_metadata_type_fkey FOREIGN KEY (type) REFERENCES public.form_type(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.legal_entities
    ADD CONSTRAINT legal_entitites_workspace_id_fkey FOREIGN KEY (workspace_id) REFERENCES public.workspaces(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.sub_entities
    ADD CONSTRAINT sub_entities_legal_entity_id_fkey FOREIGN KEY (legal_entity_id) REFERENCES public.legal_entities(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspace_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES public.lead(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
