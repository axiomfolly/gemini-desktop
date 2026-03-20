const evasionScript = `
  Object.defineProperty(navigator, 'webdriver', { get: () => false });

  if (!window.chrome) {
    window.chrome = {
      app: { isInstalled: false },
      runtime: {
        OnInstalledReason: { CHROME_UPDATE: 'chrome_update' },
        OnRestartRequiredReason: { APP_UPDATE: 'app_update' },
        PlatformOs: { MAC: 'mac' }
      }
    };
  }

  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Array;
  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Promise;
  delete window.cdc_adoQpoasnfa76pfcZLmcfl_Symbol;
`;

window.addEventListener('DOMContentLoaded', () => {
    const script = document.createElement('script');
    script.textContent = evasionScript;
    (document.head || document.documentElement).appendChild(script);
    script.remove();
});
