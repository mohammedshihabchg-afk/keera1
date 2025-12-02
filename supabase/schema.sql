-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Profiles table (extends auth.users)
create table public.profiles (
  id uuid references auth.users not null primary key,
  role text check (role in ('customer', 'driver')) not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Drivers table
create table public.drivers (
  id uuid references auth.users not null primary key,
  full_name text not null,
  phone text unique not null,
  profile_image_url text,
  national_id text unique not null,
  national_id_front_url text not null,
  national_id_back_url text,
  driver_license_number text unique not null,
  license_type text not null,
  license_expiry date not null,
  license_image_url text not null,
  vehicle_type text not null,
  plate_number text unique not null,
  vehicle_color text not null,
  vehicle_image_url text not null,
  verification_status text default 'pending' check (verification_status in ('pending', 'verified', 'rejected')),
  rejection_reason text,
  verified_at timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Shipments table
create table public.shipments (
  id uuid default uuid_generate_v4() primary key,
  customer_id uuid references auth.users not null,
  driver_id uuid references auth.users,
  pickup_location_lat double precision not null,
  pickup_location_lng double precision not null,
  dropoff_location_lat double precision not null,
  dropoff_location_lng double precision not null,
  status text default 'pending' check (status in ('pending', 'assigned', 'picked_up', 'delivered', 'cancelled')),
  tracking_code text unique default substring(uuid_generate_v4()::text from 1 for 8),
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Tracking Live table
create table public.tracking_live (
  id uuid default uuid_generate_v4() primary key,
  driver_id uuid references auth.users not null,
  lat double precision not null,
  lng double precision not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable RLS
alter table public.profiles enable row level security;
alter table public.drivers enable row level security;
alter table public.shipments enable row level security;
alter table public.tracking_live enable row level security;

-- Basic Policies (To be refined)
create policy "Public profiles are viewable by everyone." on public.profiles for select using (true);
create policy "Users can insert their own profile." on public.profiles for insert with check (auth.uid() = id);

create policy "Drivers can view their own data." on public.drivers for select using (auth.uid() = id);
create policy "Drivers can update their own data." on public.drivers for update using (auth.uid() = id);

create policy "Customers can view their own shipments." on public.shipments for select using (auth.uid() = customer_id);
create policy "Drivers can view assigned shipments." on public.shipments for select using (auth.uid() = driver_id);
