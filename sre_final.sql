PGDMP         3         
        |         	   sre_final    15.1    15.1 ,    5           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            6           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            7           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            8           1262    91675 	   sre_final    DATABASE     }   CREATE DATABASE sre_final WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE sre_final;
                postgres    false            �            1259    91806    carts    TABLE       CREATE TABLE public.carts (
    id character varying(36) NOT NULL,
    base_total_price numeric(16,2),
    tax_amount numeric(16,2),
    tax_percent numeric(10,2),
    discount_amount numeric(16,2),
    discount_percent numeric(10,2),
    grand_total numeric(16,2)
);
    DROP TABLE public.carts;
       public         heap    postgres    false            �            1259    91721 
   categories    TABLE     )  CREATE TABLE public.categories (
    id character varying(36) NOT NULL,
    parent_id character varying(36),
    section_id character varying(36),
    name character varying(100),
    slug character varying(100),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    91791    product_categories    TABLE     �   CREATE TABLE public.product_categories (
    category_id character varying(36) NOT NULL,
    product_id character varying(36) NOT NULL
);
 &   DROP TABLE public.product_categories;
       public         heap    postgres    false            �            1259    91774    products    TABLE       CREATE TABLE public.products (
    id character varying(36) NOT NULL,
    parent_id character varying(36),
    user_id character varying(36),
    sku character varying(100),
    name character varying(255),
    slug character varying(255),
    price numeric(16,2),
    stock bigint,
    weight numeric(10,2),
    short_description text,
    description text,
    status bigint DEFAULT 0,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    91676    roles    TABLE       CREATE TABLE public.roles (
    id character varying(36) NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    91715    sections    TABLE     �   CREATE TABLE public.sections (
    id character varying(36) NOT NULL,
    name character varying(100),
    slug character varying(100),
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);
    DROP TABLE public.sections;
       public         heap    postgres    false            �            1259    91759    users    TABLE     �  CREATE TABLE public.users (
    id character varying(36) NOT NULL,
    role_id character varying(36),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(255) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            2          0    91806    carts 
   TABLE DATA           ~   COPY public.carts (id, base_total_price, tax_amount, tax_percent, discount_amount, discount_percent, grand_total) FROM stdin;
    public          postgres    false    220   �5       .          0    91721 
   categories 
   TABLE DATA           c   COPY public.categories (id, parent_id, section_id, name, slug, created_at, updated_at) FROM stdin;
    public          postgres    false    216   P9       1          0    91791    product_categories 
   TABLE DATA           E   COPY public.product_categories (category_id, product_id) FROM stdin;
    public          postgres    false    219   m9       0          0    91774    products 
   TABLE DATA           �   COPY public.products (id, parent_id, user_id, sku, name, slug, price, stock, weight, short_description, description, status, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    218   �9       ,          0    91676    roles 
   TABLE DATA           Z   COPY public.roles (id, name, description, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    214   �?       -          0    91715    sections 
   TABLE DATA           J   COPY public.sections (id, name, slug, created_at, updated_at) FROM stdin;
    public          postgres    false    215   �?       /          0    91759    users 
   TABLE DATA           �   COPY public.users (id, role_id, first_name, last_name, email, password, remember_token, created_at, updated_at, deleted_at) FROM stdin;
    public          postgres    false    217   @       �           2606    91810    carts carts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
       public            postgres    false    220            �           2606    91725    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    216            �           2606    91795 *   product_categories product_categories_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (category_id, product_id);
 T   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_categories_pkey;
       public            postgres    false    219    219            �           2606    91781    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    218            �           2606    91680    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    214            �           2606    91719    sections sections_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sections DROP CONSTRAINT sections_pkey;
       public            postgres    false    215            �           2606    91765    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            �           1259    91811    idx_carts_id    INDEX     C   CREATE UNIQUE INDEX idx_carts_id ON public.carts USING btree (id);
     DROP INDEX public.idx_carts_id;
       public            postgres    false    220            �           1259    91737    idx_categories_id    INDEX     M   CREATE UNIQUE INDEX idx_categories_id ON public.categories USING btree (id);
 %   DROP INDEX public.idx_categories_id;
       public            postgres    false    216            �           1259    91736    idx_categories_section_id    INDEX     V   CREATE INDEX idx_categories_section_id ON public.categories USING btree (section_id);
 -   DROP INDEX public.idx_categories_section_id;
       public            postgres    false    216            �           1259    91790    idx_products_id    INDEX     I   CREATE UNIQUE INDEX idx_products_id ON public.products USING btree (id);
 #   DROP INDEX public.idx_products_id;
       public            postgres    false    218            �           1259    91789    idx_products_parent_id    INDEX     P   CREATE INDEX idx_products_parent_id ON public.products USING btree (parent_id);
 *   DROP INDEX public.idx_products_parent_id;
       public            postgres    false    218            �           1259    91787    idx_products_sku    INDEX     D   CREATE INDEX idx_products_sku ON public.products USING btree (sku);
 $   DROP INDEX public.idx_products_sku;
       public            postgres    false    218            �           1259    91788    idx_products_user_id    INDEX     L   CREATE INDEX idx_products_user_id ON public.products USING btree (user_id);
 (   DROP INDEX public.idx_products_user_id;
       public            postgres    false    218            }           1259    91682    idx_roles_id    INDEX     C   CREATE UNIQUE INDEX idx_roles_id ON public.roles USING btree (id);
     DROP INDEX public.idx_roles_id;
       public            postgres    false    214            ~           1259    91681    idx_roles_name    INDEX     @   CREATE INDEX idx_roles_name ON public.roles USING btree (name);
 "   DROP INDEX public.idx_roles_name;
       public            postgres    false    214            �           1259    91720    idx_sections_id    INDEX     I   CREATE UNIQUE INDEX idx_sections_id ON public.sections USING btree (id);
 #   DROP INDEX public.idx_sections_id;
       public            postgres    false    215            �           1259    91771    idx_users_email    INDEX     I   CREATE UNIQUE INDEX idx_users_email ON public.users USING btree (email);
 #   DROP INDEX public.idx_users_email;
       public            postgres    false    217            �           1259    91773    idx_users_id    INDEX     C   CREATE UNIQUE INDEX idx_users_id ON public.users USING btree (id);
     DROP INDEX public.idx_users_id;
       public            postgres    false    217            �           1259    91772    idx_users_role_id    INDEX     F   CREATE INDEX idx_users_role_id ON public.users USING btree (role_id);
 %   DROP INDEX public.idx_users_role_id;
       public            postgres    false    217            �           2606    91731     categories fk_categories_section    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_categories_section FOREIGN KEY (section_id) REFERENCES public.sections(id);
 J   ALTER TABLE ONLY public.categories DROP CONSTRAINT fk_categories_section;
       public          postgres    false    216    3203    215            �           2606    91796 1   product_categories fk_product_categories_category    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT fk_product_categories_category FOREIGN KEY (category_id) REFERENCES public.categories(id);
 [   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT fk_product_categories_category;
       public          postgres    false    219    216    3205            �           2606    91801 0   product_categories fk_product_categories_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT fk_product_categories_product FOREIGN KEY (product_id) REFERENCES public.products(id);
 Z   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT fk_product_categories_product;
       public          postgres    false    218    219    3218            �           2606    91782    products fk_products_user    FK CONSTRAINT     x   ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_products_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.products DROP CONSTRAINT fk_products_user;
       public          postgres    false    3212    217    218            �           2606    91726 !   categories fk_sections_categories    FK CONSTRAINT     �   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_sections_categories FOREIGN KEY (section_id) REFERENCES public.sections(id);
 K   ALTER TABLE ONLY public.categories DROP CONSTRAINT fk_sections_categories;
       public          postgres    false    216    3203    215            �           2606    91766    users fk_users_role    FK CONSTRAINT     r   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES public.roles(id);
 =   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_users_role;
       public          postgres    false    214    3200    217            2   _  x��VK��8\ϻ-���w�`���LK��l�(RJ��Onњ�y�0o��	�jz����B�s�}�{��Y2^��҇0��>!-��0d��wT���*0\6�F,<s��Z��%��� s8�]=&SX�e�0]UY
��P:���ܐ{��m/�M�9�3cۂ��l4���0^��NB�iM�}�B�H���9�9��0���ܔ���X^q�ΰ�-��ӭ�1�ǰ���=��(t�\�f�������&�t9�0�*{��vk�҅3��4��i�S�[�5)@�[���{9�{9_7�{��#��,�w�Y�A��1�Vɓ���J��Ag�"8�6^�P�2|�e��N��#H�^k���t�N�Cc��ha{�c�������˖}�-�5�4��b�M��{bL��)���y�9�� ]f�$n�>3H�6�D�� 9�:��G�G\�θ-�\qZ�ǥvp]�w������ oa�� ����-�j�` [��zރ֍��;a�)|iB��W���K��3���+�cؗ��v�����YJ/�6�<=�l�����j]_����/���&Ę�qpP��?��~��a��#�����;��ؗ��>9=��f���~�Щ�$��I�������m�ۿ,l*�l���t}bt�����|���mk��@�#�l�3ǖLfW�����d��88�F�;��|��F����ឥF��{��~�Vw���������fWEݸ�-Y�Ԙ�NCo���d/릂�gye���,cƷ��5��0��]'{�O��Y�X�?>�]��-S��w��/�g�V��eV+\�Kƽ6p�5��nD�,��z��ewD����0�ω>g������o��      .      x������ � �      1      x������ � �      0   /  x��YKo7>ӿb��,�~��E�6iݤP �Kƪm9YI��;kɶvW�6����y|�ͬK18�H�,H�Xm,�g�K���DÓ�4gB��4 �h�iVN*)y�7Ч��n�߯��o�ܮ����L�����Kh���q����j�����&}����o�n�|I}N}Zw�M�Ym�o���/[�Mms5������fآ%7GkƲ��G۴�N������K�.o�cFٟ�>#��ǅ�v�J^���`���9�	�������U��"����3Yxr���ه~���=<����'oq�y�<��y.�֚jeZ��La���y��#U�9RUK�vۢ��f;޲m>e�-��5�Gg�k�f8zt�u�Â�=禷����Y��	�O�hz���:H�1��c��!E������b�%1�8#5H�"؜��dA(܆|�3��o��1ޒ��6?������D�S���)��f{O���#��Ǳ�7G)Z��`�������4R��},��~g���UA���Ŧ^�D���e<,���ʓ���W�Sv�!B���u%N�-��E��P[76s�_j�����$巎�m�XO>�R��(��)�H����x�-2Ǵ��C�d�.I�R��e���@U��@܀���ɧ�e-<�CLڭ=����ns��_p��ޏ̦`�7D�}��:���z��y=��<�'La� o�� ��3�J���u�5�SqK&��Ӡ��a����X������I��$r����􊕼��ϊ��V�
�z�CM/*����Z]�W)����"e��tx��Ĕ���!4q�9�2#��x#��8��l��w4������	n�v�ZN=y����y���e�0���!���La������5���]�s<s�gý̮τ�2�yq�g���i��O��z��W�
��8��Րj���i�?���|ޟ������L�yN&c��R��H%C�`���@2�b���X�d,��"���}�:���^���:�mTIk��l ��O�G��><���(1�>����s�+�c	�+��b�2�XT���E�s�6�>s�^@�t��9��e�u_�L�+юݶB~��Li�2�=��|W�^Ô�R�k1_�a*���j|j��_�z^��-���_J��U����^��R�,@&�(���eJ�g)*+.	A���32���l� A��ɋ."� aIk�7������9�_�`�~?ؼ���i�P��D�p� �N4O���c�4�N�൲dr��=��9�[Z���ʞ�,EW�*��������B�I2)]��R��y�6�,�3�����E�{��v9���^����^d�Ge��Z}O��&j�2�����zE��_�Q,���sg�e�/�q͢���l�)��'�VtF�:��r�X�(��z�@H��y�:H�a�K���0��&���K�ZǄ���m������&7I�� i�$�5Z��
���񾴼|��sͻRuA{�d���O�>˲;�
�%����+�JQ2O��o�D���K��'�+���d|�b@}j/..��R�D      ,   "   x�3�tL����L�
E�9��1~����� ���      -      x������ � �      /      x����N�H�u��`7*S�+'�����M]c��t�y�)��i5��MX��t>����$A1 ��BƐ�V�(r͸q`0([����wg�r��/�/?�Y��d��Ѿ&�ӻ�ϋ�jFcn��E�X}^��uYd����$[��dxP�
 ""���C�1�0"��?������=���F((G�	�v�B�&1���Ҁ�6��|�=��&_^���0���n	��k�1}��&MAB�np�C�R)k�u֐�p^40Y�EhZ�T��`y�W������y�L)(%d��&�i�&PJ& C�A��Gɰ��k���B����e��O��^�G^�����4�B�[�>d*��j����0��[!��%��XE�!�����t5�m��L²�ۓ������զ�Re�~�SX��LoҤ@�H���F�T��*�^���x�QH�~S��n��j6O+�M3u��6?7�L>͒����&�1��H#�2�FKo�p��	�x"Ym�u][�yX�?����r4���∨����4)���ya�,BƝ�ʥ7N�O�e�w�۫��/4�24�nx6���y���tQ~�4N�~�xM�Q&��2eӍ�1Bm��S�8��� ��;�Q]�E���zr1��{�ʗ�~��K�sNB��X�&E`<F�*�PakS3Du��U�Wf���ۺ���nݛ��_��)5S�a��v널��2�K��W2}C5#�a�t�DY<�3UX���4v<͏o��j��I?m"�|�o�&M������ߓV=e     