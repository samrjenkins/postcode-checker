# frozen_string_literal: true

Lsoa.find_or_create_by!(name: 'Lambeth')
Lsoa.find_or_create_by!(name: 'Southwark')

AllowedPostcode.find_or_create_by!(postcode: 'sh241aa')
AllowedPostcode.find_or_create_by!(postcode: 'sh241ab')
