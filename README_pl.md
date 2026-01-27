# BadWDSD

**Wersje:** **Polski** | [English](README.md)

---

## 📚 Dokumentacja budowania

### Firmware sprzętowe (Modchip)
- **[BadWDSD/BUILD.md](BadWDSD/BUILD.md)** (English) | **[BadWDSD/BUILD_pl.md](BadWDSD/BUILD_pl.md)** (Polski)  
  → Buduje **`.uf2`** firmware dla Raspberry Pi Pico / Pico Zero (sprzęt modchipu)

### Payloady oprogramowania
- **[BadWDSD-Stage/BUILD.md](BadWDSD-Stage/BUILD.md)** (English) | **[BadWDSD-Stage/BUILD_pl.md](BadWDSD-Stage/BUILD_pl.md)** (Polski)  
  → Buduje **`Stagex.bin`** – główny payload modchipu BadWDSD (instalowany na PS3 NOR flash / MMIO)

- **[BadWDSD-SW/BUILD.md](BadWDSD-SW/BUILD.md)** (English) | **[BadWDSD-SW/BUILD_pl.md](BadWDSD-SW/BUILD_pl.md)** (Polski)  
  → Buduje **`.pkg`** pakiet instalacyjny dla PS3 (używany do instalacji Stagex.bin i bootowania OtherOS)

### qCFW (Quasi-CFW)
- **[QCFW_GEN.md](QCFW_GEN.md)** (English) | **[QCFW_GEN_pl.md](QCFW_GEN_pl.md)** (Polski)  
  → Generuje **`CoreOS.bin`** – qCFW (quasi-CFW) dla PS3 z modchipem BadWDSD (persystentny CFW)

---

To jest modchip sprzętowy dla **Sony PlayStation 3**. Używając **Raspberry Pi Pico (RP2040)**, możliwe jest uruchomienie **qCFW** na modelach niekompatybilnych z CFW.

# Obsługiwane modele

Wszystkie **CECH-2500**

Wszystkie **CECH-3000**

**CECH-4x00** z **NOR** flash

<img width="284" height="370" alt="firefox_Z4WaABYPQH" src="https://github.com/user-attachments/assets/7066c760-a097-45ba-9697-6022c9cf1e07" />

**CECH-4x00** z **eMMC** flash **NIE** jest obsługiwane

<img width="220" height="285" alt="firefox_LGBpLg82NH" src="https://github.com/user-attachments/assets/6592b99e-f80f-4319-a450-10a894aa5164" />

Jednym ze sposobów sprawdzenia, czy konsola ma eMMC, jest wejście w tryb bezpieczny. Jeśli widzisz opcję **Change system storage**, to jest eMMC.

Innym sposobem jest próba instalacji Stagex. Jeśli pojawi się komunikat **Flash is not NOR**, to jest eMMC.

# Co to jest qCFW?

Nadal nie można zainstalować CFW PUP, więc trzeba było stworzyć nową wersję CFW. Nazywa się to **quasi-CFW**.

Jest w dużej mierze oparte na **Evilnat PEX CFW**. I będzie obsługiwać wszystkie funkcje z wyjątkiem: **Zrzutu eid_root_key i wszystkiego, co tego wymaga**.

[Cobra](https://github.com/aomsin2526/Cobra-PS3-qCFW) musi być aktywne przez cały czas, w przeciwnym razie niektóre funkcje nie będą działać poprawnie.

# Specyfika qCFW

Z nieznanych przyczyn, gdy włączasz konsolę za pomocą bezprzewodowego kontrolera, nie będzie się synchronizował. Musisz zrestartować kontroler, aby się zsynchronizował.

# Uwaga dotycząca trybu DEX

Tryb DEX jest w pełni obsługiwany. Ale jakakolwiek instalacja lub aktualizacja firmware nie jest możliwa w tym trybie.

Oznacza to, że jeśli z jakiegoś powodu potrzebujesz przeinstalować firmware, np. z powodu uszkodzonego HDD, utkniesz.

Aby odzyskać, użyj pinu **BANKSEL** na modchipie, aby wrócić do OFW.

# Instalacja (Oprogramowanie)

**PRZY PIERWSZEJ INSTALACJI, NAJPIERW ZRÓB KOPIĘ ZAPASOWĄ FLASH!!!. JEŚLI COŚ PÓJDZIE ZBYT ŹLE I NIE MASZ KOPII ZAPASOWEJ, TWOJA KONSOLA MOŻE BYĆ TRWALE ZEPSUTA**

1. Przygotuj dysk USB, **USUWAJĄC stary folder qcfw, jeśli istniał, NIE NADPISUJ!!**
   następnie pobierz [qCFW](https://github.com/aomsin2526/BadWDSD/releases) i rozpakuj go na dysk w ten sposób:

<img width="617" height="174" alt="explorer_71wt3KBo5T" src="https://github.com/user-attachments/assets/b63da1b3-3982-4703-b07b-8ae8b209349a" />

2. Zainstaluj wersję HEN, która zawiera instalator qCFW
3. Podłącz dysk USB do **NAJDALSZEGO PRAWEJ** portu USB PS3
4. Na XMB, włącz HEN, a następnie użyj opcji **Network -> Hybrid Firmware Tools -> QCFW Installer -> Install Stagex**. Musi pokazać **Success**
5. Jeśli jeszcze nie, zainstaluj modchip zgodnie z sekcją **Instalacja (Sprzęt)**
6. Po zainstalowaniu modchipu i podłączeniu zasilania, poczekaj, aż LED modchipu stanie się stałe. Jeśli nie stanie się stałe po chwili, sprawdź przewód **SC_RX/SC_TX**
7. Włącz konsolę. LED modchipu powinien krótko migać z potrójnym sygnałem dźwiękowym zaraz po tym. Oznacza to, że exploit się powiódł. Jeśli konsola ciągle się wyłącza i włącza, sprawdź przewód **CMD/CLK** i **Stagex**
8. Powinieneś być teraz na XMB. Teraz włącz HEN, a następnie użyj opcji **Install qCFW**
9. Jeśli powie ci, aby przeinstalować firmware i spróbować ponownie, zrób to **RAZ**.
10. Ekran wyda się zamrożony. Trwa instalacja. Ten proces trwa 10-20 minut. Jeśli coś pójdzie nie tak podczas tego kroku, nadal powinieneś być w stanie odzyskać, wchodząc w tryb bezpieczny i przeinstalowując firmware normalnie
11. Następnie zrestartuje się automatycznie. Powinieneś być na qCFW i zobaczyć logo Evilnat.
12. Gratulacje! Instalacja qCFW jest zakończona

Od teraz modchip będzie wymagany do uruchomienia konsoli, dopóki nie wrócisz do OFW ponownie

Można to zrobić, przeinstalowując firmware OFW/HFW normalnie. Następnie możesz wyłączyć lub odinstalować modchip

Jeśli sprawy pójdą zbyt źle do tego stopnia, że nie będziesz mógł w ogóle wejść w tryb bezpieczny, możesz użyć pinu **BANKSEL** zamiast tego.

# Instalacja (Sprzęt)

Obecnie obsługiwane są **Raspberry Pi Pico (RP2040)** i **RP2040-Zero**.

**Zainstaluj modchip dopiero po zainstalowaniu Stagex na flash konsoli z powyższej sekcji. W przeciwnym razie nie uruchomi się, jeśli już zainstalowałeś modchip, możesz użyć pinu HOLD, aby tymczasowo wyłączyć modchip bez odlutowywania.**

**Ponieważ nie mam modeli 2500 i 3000 do testowania, musi to być zrobione przez inne osoby. Jeśli znasz lokalizację lutowania, powiedz mi. Dzięki.**

<details>
  <summary> <b>Pico</b> </summary>
<p>
<img width="1100" height="800" alt="raspberry_pi_pico_pinout - Copy" src="https://github.com/user-attachments/assets/e1393136-d60f-4822-a818-f27cf2b1456b" />
</p>
</details>

<details>
  <summary> <b>RP2040-Zero</b> </summary>
<p>
<img src="https://github.com/user-attachments/assets/8304c258-386b-4f2c-84ee-5fd5f6f90217" />
</p>
</details>

<details>
  <summary> <b>3000</b> </summary>
<p>
<img src="https://github.com/user-attachments/assets/6787886e-58a6-4fe9-877c-7ce4efbf8af7" />
</p>
</details>

<details>
  <summary> <b>4x00</b> </summary>
<p>
<img src="https://github.com/user-attachments/assets/9910be97-5c85-4b48-9edb-c2d7a4ecabd9" />

<img width="481" height="384" alt="firefox_hjbEN8ZhUV" src="https://github.com/user-attachments/assets/fb19f60f-76ee-4e76-a164-83b988cdf286" />

<img width="501" height="400" alt="firefox_ybeL3zep1j" src="https://github.com/user-attachments/assets/71580063-2a03-4b6e-8433-e5f99e925e89" />
</p>
</details>

Aby wgrać plik .uf2 (jest zawarty w zip qCFW), po prostu podłącz port USB modchipu do komputera, naciskając przycisk **BOOTSEL**. Następnie pojawi się nowy dysk, po prostu przeciągnij plik .uf2 na niego.

Powinieneś zobaczyć migające LED. Wgrywanie zakończone sukcesem i gotowe do użycia. Możesz go odłączyć od komputera.

Oprócz zasilania i masy, musisz tylko przylutować 4 przewody oznaczone na czerwono **(CMD, CLK, SC_RX, SC_TX)**. Inne piny są opcjonalne.

Możliwe jest zasilanie modchipu za pomocą zewnętrznego zasilacza, o ile jest aktywny podczas stand-by PS3

# Opis pinów

**PINY SYGNAŁOWE:**

**CLK** - sygnał XDR CLK

**CMD** - sygnał XDR CMD

**SC_TX/SC_RX** - sygnał UART Syscon

**DEBUG** - Opcjonalny sygnał UART modchipu, do debugowania i dostępu do syscon **(baud 576000, NIE 57600!)**


**PINY KONFIGURACYJNE:**

Zwarte do masy, aby aktywować

**HOLD** - Wyłącz modchip bez konieczności usuwania zasilania lub odlutowywania

**LITE** - TODO

**BANKSEL** - Wróć do OFW siłą. Jest równoważne poleceniu syscon **w 1224 00**. Używaj tylko w razie absolutnej konieczności. Nie możesz włączyć konsoli, gdy ten pin jest zwarty

# Aktualizacja qCFW

Nie możesz aktualizować qCFW będąc na qCFW. Musisz najpierw wrócić do OFW.

Po prostu przeinstaluj firmware normalnie, a następnie użyj opcji **Install qCFW** z zaktualizowanymi plikami na USB ponownie. Nie trzeba robić nic więcej

**Podczas aktualizowania plików na USB, najpierw usuń cały folder qcfw. Nie nadpisuj, bo może powodować problemy.**

# Powrót do OFW metodą PUP (Zalecane)

Zawsze używaj tej metody, gdy to możliwe. Po prostu przeinstaluj firmware jak zwykle. Nie są wymagane żadne dodatkowe kroki.

Jeśli chcesz odinstalować modchip, możesz to zrobić po tym

# Powrót do OFW za pomocą pinu BANKSEL

**Unikaj tego, chyba że absolutnie konieczne.**

1. Odłącz konsolę
2. Zewrzyj pin **BANKSEL** do masy
3. Podłącz konsolę, poczekaj, aż LED modchipu zacznie migać bardzo szybko. Wtedy jest sukces. Nie możesz włączyć konsoli, gdy ten pin jest zwarty
4. Odłącz konsolę i rozewrzyj pin. **W razie potrzeby** usuń lub użyj pinu HOLD, aby wyłączyć modchip
5. Podłącz konsolę ponownie i włącz ją, prawdopodobnie zobaczysz czarny ekran. To jest oczekiwane, ponieważ dev_flash nadal jest qCFW, ale jesteś teraz na OFW
6. Wejdź w tryb bezpieczny i przeinstaluj firmware normalnie, aby uzyskać pełne odzyskanie

# Downgrade

Po uruchomieniu konsoli z modchipem, możliwe jest obniżenie wersji firmware do 4.80. Nie można tego zrobić w XMB. Musisz użyć trybu bezpiecznego.

# OtherOS

Różni się od CFW. Po prostu wykonaj te kroki.

1. Pobierz [dtbImage.ps3.zfself](https://github.com/aomsin2526/ps3-petitboot-kexec-patched/releases) i umieść go w głównym katalogu dysku USB
2. Podłącz dysk USB do **NAJDALSZEGO PRAWEJ** portu USB PS3
3. Na XMB, użyj opcji **Network -> Custom Firmware Tools -> OtherOS Tools -> Install OtherOS (qCFW)**. Powinno pokazać **Success**
4. Użyj opcji **Boot OtherOS (qCFW)**. Powinno od razu wejść w petitboot

# Dostęp do Syscon

Nie możesz już uzyskać dostępu do syscon w stary sposób. Musi to być zrobione przez modchip. Po prostu podłącz pin **DEBUG** modchipu do adaptera UART.

<img width="1206" height="644" alt="Termite_s1m3OjonO8" src="https://github.com/user-attachments/assets/b8ba3786-d2ab-488f-b6c2-85032f0615de" />

# NoBT

TODO. Wymaga pinu LITE i sprzętowego programatora do pierwszej instalacji, jeśli jesteś już w pętli aktualizacji.

# Wsparcie dla eMMC?

W bardzo krótkim podsumowaniu, to, co robi modchip, to zapisywanie tego kodu do pamięci RAM przy starcie:

```
stage_entry:
    // Skok do 0x2401F031000, czyli 0x31000 na flash NOR, gdzie jest przechowywany Stagex.bin

    bl 4
    mflr %r3
    addi %r3, %r3, -4
    ld %r4, 24(%r3)
    mtctr %r4
    bctr

    .quad 0x2401F031000
```

Czy mamy coś takiego jak 0x2401F031000 na eMMC? Jeśli odpowiedź brzmi tak, to eMMC może być obsługiwane (z większą pracą portowania).
