module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :recapitulations do
      desc "Return all Recapitulations of DPT Surabaya 2015"
      get do
        recapitulations = Array.new

        # Prepare conditions based on params
        valid_params = {
          kategori: 'category_id',
          kecamatan: 'subdistrict_id'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Recapitulation.includes(:category, :subdistrict, :dpts)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |recapitulation|
            recapitulations << {
              id: recapitulation.id,
              kategori: {
                id: recapitulation.category_id,
                nama: recapitulation.category.name
              },
              kecamatan: {
                id: recapitulation.subdistrict_id,
                nama: recapitulation.subdistrict.name
              },
              dpt: recapitulation.build_dpt,
              pengguna_hak_pilih: recapitulation.using_suffrage,
              presentase_pemilih: recapitulation.voter_presentation
            }
          end

        {
          results: {
            count: recapitulations.count,
            total: Recapitulation.where(conditions).count,
            recapitulations: recapitulations
          }
        }
      end
    end

    resource :categories do
      desc "Return all Categories"
      get do
        categories = Array.new

        Category.all.each do |category|
          categories << {
            id: category.id,
            name: category.name
          }
        end

        {
          results: {
            count: Category.count,
            total: Category.count,
            categories: categories
          }
        }
      end
    end

    resource :kecamatan do
      desc "Return all Subdistrict"
      get do
        subdistricts = Array.new

        Subdistrict.all.each do |subdistrict|
          subdistricts << {
            id: subdistrict.id,
            name: subdistrict.name
          }
        end

        {
          results: {
            count: Subdistrict.count,
            total: Subdistrict.count,
            subdistricts: subdistricts
          }
        }
      end
    end
  end
end