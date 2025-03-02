module.exports = ({ env }) => ({
  upload: {
    config: {
      provider: '@strapi/provider-upload-cloudinary',
      providerOptions: {
        cloud_name: env('CLOUDINARY_NAME'),
        api_key: env('CLOUDINARY_KEY'),
        api_secret: env('CLOUDINARY_SECRET'),
        secure: true,
      },
      actionOptions: {
        upload: {
          folder: 'ck-property',
          resource_type: 'auto',
          transformation: {
            quality: 'auto:best',
            fetch_format: 'auto',
          },
        },
        delete: {},
      },
    },
  },
})
